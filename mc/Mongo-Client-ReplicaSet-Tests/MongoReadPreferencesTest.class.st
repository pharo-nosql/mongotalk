Class {
	#name : #MongoReadPreferencesTest,
	#superclass : #MongoClientReplicaSetTest,
	#category : 'Mongo-Client-ReplicaSet-Tests'
}

{ #category : #testing }
MongoReadPreferencesTest class >> isAbstract [
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ self name = #MongoReadPreferencesTest
]

{ #category : #running }
MongoReadPreferencesTest >> doRead [
	client mongoDo: [ :mongo | ^ self doReadOnMongo: mongo ].
	^ self fail
]

{ #category : #hooks }
MongoReadPreferencesTest >> doReadOnCollection: collection [
	^ self subclassResponsibility
]

{ #category : #running }
MongoReadPreferencesTest >> doReadOnMongo: mongo [
	| database collection |
	database := mongo databaseNamed: MongoReplicationTestResources databaseName.
	collection := database collectionAt: self collectionNameForTesting.
	^ self doReadOnCollection: collection
]

{ #category : #running }
MongoReadPreferencesTest >> doReadWith: aMongoReadPreference [
	client
		mongoDo: [ :mongo | ^ self doReadOnMongo: mongo ]
		readPreference: aMongoReadPreference.
	self fail
]

{ #category : #running }
MongoReadPreferencesTest >> doWrite [
	client primaryMongoDo: [ :mongo |
		| database collection |
		database := mongo databaseNamed: MongoReplicationTestResources databaseName.
		collection := database addCollection: self collectionNameForTesting.
		^ self doWriteOnCollection: collection ].

	self fail.
]

{ #category : #hooks }
MongoReadPreferencesTest >> doWriteOnCollection: collection [
	self subclassResponsibility
]

{ #category : #running }
MongoReadPreferencesTest >> maxStaleness [
	"90 seconds is the minimum possible value according to mongodb documentation."

	^ 90 seconds
]

{ #category : #running }
MongoReadPreferencesTest >> prepareScenarioWhereAllExceptCStopped [

	"Start client and wait it's available."
	self startClientAndWait.

	"Write and read on primary (A)"
	self writeAndReadFromA.

	"Then stop all but C, and finally wait until monitors realize."
	self stopAllExceptCAndWait.

]

{ #category : #running }
MongoReadPreferencesTest >> setUp [
	super setUp.
	client := self newClient.
]

{ #category : #tests }
MongoReadPreferencesTest >> testGlobalReadPreferencePrimary [

	"Set global readPreference"
	client settings readPreference: MongoReadPreference newPrimary.

	self prepareScenarioWhereAllExceptCStopped.

	self
		should: [ self doRead ]
		raise: MongoServerSelectionTimeout.

]

{ #category : #tests }
MongoReadPreferencesTest >> testGlobalReadPreferencePrimaryPreferred [

	"Set global readPreference"
	client settings readPreference: MongoReadPreference newPrimaryPreferred.

	self prepareScenarioWhereAllExceptCStopped.

	"It will read from C"
	client mongoDo: [ :mongo |
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlC.
		self doReadOnMongo: mongo ].
]

{ #category : #tests }
MongoReadPreferencesTest >> testMaxStaleness [

	| readPreferenceWithMaxStaleness |
	self timeLimit: self defaultTimeLimit + self maxStaleness.

	readPreferenceWithMaxStaleness :=
		MongoReadPreference newPrimaryPreferred
			maxStaleness: self maxStaleness;
			yourself.
	client settings readPreference: readPreferenceWithMaxStaleness.

	self prepareScenarioWhereAllExceptCStopped.

	client mongoDo: [ :mongo |
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlC.
		self doReadOnMongo: mongo ].

	"Wait until staleness of C is too high."
	self maxStaleness wait.

	[ client mongoDo: [ :mongo |
		self fail: 'should not find a server because staleness is too high' ] ]
			on: MongoServerSelectionTimeout
			do: [:e | Transcript << 'expected timeout'; cr ].

	MongoReplicationTestResources continueAllServers.
	self waitMonitorsHeartbeatAndTimeout.
	
	"Ensure it reads again"
	self doRead.

]

{ #category : #tests }
MongoReadPreferencesTest >> testOperationReadPreferenceNearest [
	| servers minLatency nearestServerUrls |
	self startClientAndWait.
	self writeAndReadFromA.
	servers := client topology servers.

	self flag: #todo. "roundtrip may be 0 with local servers so should simulate latency. Then next assert must pass."
"	self
		assert: (servers collect: #roundtripDurationAverage as: Set) size
		equals: 3."

	minLatency := (servers collect: #roundtripDurationAverage) min.
	nearestServerUrls := servers
		select: [:each | each roundtripDurationAverage = minLatency ]
		thenCollect: #urlString.
	client
		mongoDo: [ :mongo |
			self assert: (nearestServerUrls includes: mongo urlString).
			self doReadOnMongo: mongo ]
		readPreference: MongoReadPreference newNearest
		localThreshold: 0 milliseconds

]

{ #category : #tests }
MongoReadPreferencesTest >> testOperationReadPreferencePrimary [

	"Set another read preference as global."
	client settings readPreference: MongoReadPreference newPrimaryPreferred.

	self prepareScenarioWhereAllExceptCStopped.
	
	"It can't do a read command from the secondary (B)"
	self
		should: [ self doReadWith: MongoReadPreference newPrimary ]
		raise: MongoServerSelectionTimeout.

]

{ #category : #tests }
MongoReadPreferencesTest >> testOperationReadPreferencePrimaryPreferred [

	"Ensure the global setting is not the one being tested."
	client settings readPreference: MongoReadPreference newPrimary.

	self prepareScenarioWhereAllExceptCStopped.
	
	"It reads from secondary (C)"
	self doReadWith: MongoReadPreference newPrimaryPreferred.
]

{ #category : #tests }
MongoReadPreferencesTest >> testReadRetryInC [

	client settings readPreference: MongoReadPreference newPrimaryPreferred.

	self startClientAndWait.
	self writeAndReadFromA.
	self stopAllExceptC.
	
	"First time, it will use A since it was the primary up to now, but will error."
	client mongoDo: [ :mongo |
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlA.
		self
			should: [ self doReadOnMongo: mongo ]
			raise: ConnectionTimedOut ].

	self waitMonitorsHeartbeatAndTimeout.

	"After enough time passed, the client must know that B wasn't available.
	Then, the read on server C should succeed."
	client mongoDo: [ :mongo |
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlC.
		self doReadOnMongo: mongo ].


]

{ #category : #running }
MongoReadPreferencesTest >> writeAndReadFromA [
	"Write and read from A (error if it's another server)"

	MongoReplicationTestResources waitTestingScenario.
	
	self doWrite.

	client mongoDo: [ :mongo | 
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlA.
		self doReadOnMongo: mongo ].

]
