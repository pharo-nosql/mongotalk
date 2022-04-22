"
I have the settings for a MongoClient.

See: https://docs.mongodb.com/manual/reference/connection-string/
"
Class {
	#name : #MongoClientSettings,
	#superclass : #Object,
	#instVars : [
		'connectTimeout',
		'readPreference',
		'localThreshold',
		'serverSelectionTimeout',
		'heartbeatFrequency',
		'serverSelectionRandomGenerator',
		'socketTimeout',
		'maxConnections',
		'monitorStopTimeout',
		'client'
	],
	#category : 'Mongo-Client-Client'
}

{ #category : #'instance creation' }
MongoClientSettings class >> for: aMongoClient [
	^ self basicNew
		initializeWith: aMongoClient;
		yourself
]

{ #category : #'accessing - pool' }
MongoClientSettings >> connectTimeout [
	^ connectTimeout ifNil: [
		connectTimeout := 10 seconds ]
]

{ #category : #'accessing - pool' }
MongoClientSettings >> connectTimeout: aDuration [
	connectTimeout := aDuration.
	self updatedPoolSettings.
]

{ #category : #'accessing - monitor' }
MongoClientSettings >> heartbeatFrequency [
	"See: https://docs.mongodb.com/manual/reference/connection-string/#urioption.heartbeatFrequencyMS"

	^ heartbeatFrequency ifNil: [ 
		heartbeatFrequency := 10 seconds ]
]

{ #category : #'accessing - monitor' }
MongoClientSettings >> heartbeatFrequency: aDuration [
	heartbeatFrequency := aDuration
]

{ #category : #initialization }
MongoClientSettings >> initializeWith: aMongoClient [
	self initialize.
	client := aMongoClient
]

{ #category : #'accessing - server selection' }
MongoClientSettings >> localThreshold [
	^ localThreshold ifNil: [
		localThreshold := SmallInteger maxVal seconds ]
]

{ #category : #'accessing - server selection' }
MongoClientSettings >> localThreshold: aDuration [
	localThreshold := aDuration
]

{ #category : #'accessing - pool' }
MongoClientSettings >> maxConnections [
	^ maxConnections ifNil: [ maxConnections := 25 ]
]

{ #category : #'accessing - pool' }
MongoClientSettings >> maxConnections: aQuantity [
	maxConnections := aQuantity.
	self updatedPoolSettings.
]

{ #category : #'accessing - monitor' }
MongoClientSettings >> minHeartbeatFrequency [
	"If a client frequently rechecks a server, it MUST wait at least minHeartbeatFrequencyMS milliseconds since the previous check ended, to avoid pointless effort. This value MUST be 500 ms, and it MUST NOT be configurable. 

Source: https://github.com/mongodb/specifications/blob/573b1f58a129056d651781ad99317b6c656e050e/source/server-discovery-and-monitoring/server-discovery-and-monitoring.rst#minheartbeatfrequencyms"

	^ 500 milliSeconds
]

{ #category : #'accessing - monitor' }
MongoClientSettings >> monitorStopTimeout [
	"Answer the amount of time that can wait for each monitor to stop."

	^ monitorStopTimeout ifNil: [ monitorStopTimeout := 40 seconds ]
]

{ #category : #'accessing - monitor' }
MongoClientSettings >> monitorStopTimeout: aDuration [
	monitorStopTimeout := aDuration
]

{ #category : #'accessing - server selection' }
MongoClientSettings >> readPreference [
	^ readPreference ifNil: [
		readPreference := MongoReadPreference newPrimary ]
]

{ #category : #'accessing - server selection' }
MongoClientSettings >> readPreference: aReadPreference [
	readPreference := aReadPreference
]

{ #category : #'accessing - server selection' }
MongoClientSettings >> serverSelectionRandomGenerator [
	^ serverSelectionRandomGenerator ifNil: [
		serverSelectionRandomGenerator := SharedRandom globalGenerator ]
]

{ #category : #'accessing - server selection' }
MongoClientSettings >> serverSelectionRandomGenerator: aRandomGenerator [
	serverSelectionRandomGenerator := aRandomGenerator
]

{ #category : #'accessing - server selection' }
MongoClientSettings >> serverSelectionTimeout [
	"See: https://docs.mongodb.com/manual/reference/connection-string/#urioption.serverSelectionTimeoutMS"

	^ serverSelectionTimeout ifNil: [ 
		serverSelectionTimeout := 30 seconds ]
]

{ #category : #'accessing - server selection' }
MongoClientSettings >> serverSelectionTimeout: aDuration [
	serverSelectionTimeout := aDuration
]

{ #category : #'accessing - pool' }
MongoClientSettings >> socketTimeout [
	^ socketTimeout ifNil: [
		socketTimeout := 5 seconds ]
]

{ #category : #'accessing - pool' }
MongoClientSettings >> socketTimeout: aDuration [
	socketTimeout := aDuration.
	self updatedPoolSettings.
]

{ #category : #refreshing }
MongoClientSettings >> updatedPoolSettings [
	client ifNotNil: #updatedPoolSettings.
]
