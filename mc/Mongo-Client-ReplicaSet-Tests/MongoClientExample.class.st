"
I show a simple usage scenario of the MongoClient.

Look at class-side methods.
"
Class {
	#name : #MongoClientExample,
	#superclass : #Object,
	#instVars : [
		'client',
		'readingLoopEnabled'
	],
	#category : 'Mongo-Client-ReplicaSet-Tests'
}

{ #category : #examples }
MongoClientExample class >> openInWindows [
	"Open windows to execute the example."

	<example>
	| aWorkspace contents |

	"Open (and clean) Transcript."
	Transcript open; clear.

	"Show the example script."
	contents := Character cr join: ((self class sourceCodeAt: #scriptCode) lines allButFirst: 2).
	aWorkspace := Smalltalk tools workspace openContents: contents.
	aWorkspace label: 'Example'.
	
	"Show the replica set scenario."
	contents := ('This example uses the replica set scenario explained in the class comment of ', MongoReplicationTestResources name, ':
	
', MongoReplicationTestResources comment) surroundedBy: '"'.
	aWorkspace := Smalltalk tools workspace openContents: contents.
	aWorkspace label: 'Replica Set Scenario'.
	

]

{ #category : #examples }
MongoClientExample class >> scriptCode [
	| example |
	"Ensure the replica set scenario is ready to use."
	MongoReplicationTestResources waitTestingScenario.

	"Start client and see how read and write operations are logged
	regularly."
	example := MongoClientExample new. 
	example startClientAndLoopReadingAndWriting.

	"Freeze server A and see how client adapts to the new replica set
	topology: B will become primary."
	MongoReplicationTestResources signalStopA.

	"Freeze also server B and see how the client adapts to the 
	new replica set topology: there is no primary to write now,
	but read operations show succeed in C."
	MongoReplicationTestResources signalStopB.

	"Unfreeze A and B and the client should return to initial state."
	MongoReplicationTestResources continueAllServers.

	"Something similar should happen if you stepDown servers (check
	the Mongo>>replicaSetStepDown: for more details on this operation."
	MongoReplicationTestResources stepDownA: 30 seconds.
	MongoReplicationTestResources stepDownB: 30 seconds.

	"Stop the example."
	example stopClient.

]

{ #category : #private }
MongoClientExample >> forkReadingLoop [

	[ [ client isStarted ] whileTrue: [
		self readWithRetry.
		self readingLoopInterval wait ] ] fork.

]

{ #category : #private }
MongoClientExample >> forkWritingLoop [

	[ [ client isStarted ] whileTrue: [
		self writeWithRetry.
		self writingLoopInterval wait ] ] fork.

]

{ #category : #initialization }
MongoClientExample >> initialize [
	super initialize.
	
	client := self newClient.
	client announcer
		when: MongoTopologyUpdate
		send: #topologyUpdated:
		to: self
]

{ #category : #private }
MongoClientExample >> newClient [
	client := MongoClient withUrls: MongoReplicationTestResources allMongoUrls.
	client settings
		connectTimeout: 5 seconds;
		readPreference: self readPreference.
	^ client
]

{ #category : #'public API' }
MongoClientExample >> oneShotReadSlaveOk [
	^ client
		mongoDo: [ :mongo | 
			| database collection |
			Transcript
				show: 'reading - ';
				show: mongo urlString;
				cr.
			database := mongo databaseNamed: 'x'.
			collection := database collectionAt: 'y'.
			(collection
				commandFind: Dictionary new
				limit: 10
				readConcern: MongoReadConcern available)
					setFlagSlaveOk;
					contents ]
]

{ #category : #'public API' }
MongoClientExample >> oneShotWriteToPrimary [
	"Do a write operation (insert) to the database."
	
	^ client primaryMongoDo: [ :mongo |
		| database collection |
		Transcript show: 'writing - '; show: mongo urlString; cr.
		database := mongo databaseNamed: 'x'.
		collection := database collectionAt: 'y'.
		collection commandInsert: (Dictionary new at: 'z1' put: 'z2'; yourself) writeConcern: nil ]
]

{ #category : #accessing }
MongoClientExample >> readPreference [
	^ MongoReadPreference newPrimaryPreferred
		maxStaleness: 90 seconds;
		yourself
]

{ #category : #private }
MongoClientExample >> readWithRetry [
	[ 	self oneShotReadSlaveOk.
		Transcript show: '-> read done'; cr.
	] 	on: Error
		do: [ :firstError |
			"second try"
			Transcript show: '-> retry read ('; print: firstError; show: ')'; cr.
			[ 
				self oneShotReadSlaveOk.
				Transcript show: '---> retry read success'; cr 
			]	on: Error
				do: [ :secondError |
					Transcript show: '---> retry read failed ('; print: secondError; show: ')'; cr ]
		]
]

{ #category : #accessing }
MongoClientExample >> readingLoopInterval [
	^ 1000 milliseconds
]

{ #category : #'public API' }
MongoClientExample >> startClientAndLoopReadingAndWriting [
	client start.
	self forkReadingLoop.
	self forkWritingLoop.
]

{ #category : #'public API' }
MongoClientExample >> stopClient [
	client stop.

]

{ #category : #private }
MongoClientExample >> topologyUpdated: ann [
	Transcript
		show: 'topology - ';
		show: client topology type; space;
		show: client topology primaryUrlString; space;
		show: client topology secondaryUrlStrings.
	client isMonitoringSteadyState ifFalse: [ Transcript show: ' - CRISIS STATE' ].
	Transcript cr.

]

{ #category : #private }
MongoClientExample >> writeWithRetry [
	[ 	self oneShotWriteToPrimary.
		Transcript show: '-> write done'; cr.
	] 	on: Error
		do: [ :firstError |
			"second try"
			Transcript show: '-> retry write ('; print: firstError; show: ')'; cr.
			[ 
				self oneShotWriteToPrimary.
				Transcript show: '---> retry write success'; cr 
			]	on: Error
				do: [ :secondError |
					Transcript show: '---> retry write failed ('; print: secondError; show: ')'; cr ]
		]
]

{ #category : #accessing }
MongoClientExample >> writingLoopInterval [
	^ self readingLoopInterval
]
