"
I provide methods that are useful to  set up and manage the replica set test resources.  Follow my guide to prepare replication tests scenario. See my class-side methods.


	Scenario:
	---------
	
		mongo 'A':
			localhost:27031 -> priority 5.0 
				=> primary member in the replica set
		mongo 'B':
			localhost:27032 -> priority 3.0 
				=> secondary member in the replica set, except when A steps down
		mongo 'C':
			localhost:27033 -> priority 0.0
				=> secondary member in the replica set, can't be primary

"
Class {
	#name : #MongoBasicReplicationTestResources,
	#superclass : #Object,
	#classInstVars : [
		'replicaSet'
	],
	#category : 'Mongo-Tests-Core'
}

{ #category : #accessing }
MongoBasicReplicationTestResources class >> allMongoUrls [

	^ { self mongoUrlA. self mongoUrlB. self mongoUrlC.}
]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> cleanupSockets [

	SocketStream allInstancesDo: #destroy.
	3 timesRepeat: [ Smalltalk garbageCollect ].
	(({ Socket. SocketStream } collect: #allInstances) collect: #size) traceCr.

]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> continueAllServers [
	replicaSet servers do: #sigcont
]

{ #category : #accessing }
MongoBasicReplicationTestResources class >> databaseName [
	^ 'test'
]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> ensureStarted [
	replicaSet
		ifNil: [ self start ]
		ifNotNil: [ replicaSet ensureAllServersStarted ]
]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> initialize [
	SessionManager default registerUserClassNamed: self name

]

{ #category : #accessing }
MongoBasicReplicationTestResources class >> mongoUrlA [

	^ 'localhost:27031' asMongoUrl
]

{ #category : #accessing }
MongoBasicReplicationTestResources class >> mongoUrlB [ 

	^ 'localhost:27032' asMongoUrl
]

{ #category : #accessing }
MongoBasicReplicationTestResources class >> mongoUrlC [

	^ 'localhost:27033' asMongoUrl
]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> shutDown: aboutToQuit [
	aboutToQuit ifTrue: [ self stop ]
]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> signalStopA [
	^ (replicaSet serverAtUrl: self mongoUrlA) sigstop
]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> signalStopB [
	^ (replicaSet serverAtUrl: self mongoUrlB) sigstop
]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> startUp: resuming [
	resuming ifTrue: [ replicaSet := nil ].
]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> stepDown: aDuration url: aZnUrl [
	
	| mongo |
	mongo := Mongo url: aZnUrl.
	mongo open.
	mongo replicaSetStepDown: aDuration.
	mongo closeIfOpen
]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> stepDownA: aDuration [
	self stepDown: aDuration url: self mongoUrlA
]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> stepDownB: aDuration [
	self stepDown: aDuration url: self mongoUrlB
]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> stop [
	"Stop the testing scenario. See description in class comment."

	<example>
	replicaSet ifNotNil: [
		replicaSet ensureAllServersTerminated.
		replicaSet := nil ]
]

{ #category : #'stop/continue' }
MongoBasicReplicationTestResources class >> waitTestingScenario [

	| retryingDelay end |
	retryingDelay := 500 milliSeconds.
	end := DateAndTime now + 1 minute.

	self cleanupSockets.

	self ensureStarted.

	[	[	self assert: ((replicaSet
				serverAtUrl: self mongoUrlA)
				mongoDo: [ :mongo | mongo isMaster isPrimary ]).

			self assert: ((replicaSet
				serverAtUrl: self mongoUrlB)
				mongoDo: [ :mongo |
					| response |
					response := mongo isMaster.
					response isSecondary and: [ response staleness < 10 seconds ] ]).

			self assert: ((replicaSet
				serverAtUrl: self mongoUrlC)
				mongoDo: [ :mongo |
					| response |
					response := mongo isMaster.
					response isSecondary and: [ 
						response isPassive and: [ 
						response staleness < 10 seconds ] ]]).

			"Ensure there is no test database remaining from previous tests."
			(replicaSet serverAtUrl: self mongoUrlA) mongoDo: [ :mongo |
				(mongo databaseNames includes: self databaseName) ifTrue: [ 
					(mongo databaseNamed: self databaseName) drop ] ].		

			^ Transcript << 'READY'; cr.

		] on: Error do: [ :e | Transcript << '.' ].
				
		retryingDelay wait.

	] doWhileFalse: [ DateAndTime now > end ].

	self error: 'TIMEOUT'.

]
