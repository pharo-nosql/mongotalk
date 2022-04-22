"
I represent a mongod server, providing protocol to start and stop a OS process with the requested parameters.

See: https://docs.mongodb.com/v4.0/reference/program/mongod/

"
Class {
	#name : #MongoTestServer,
	#superclass : #Object,
	#instVars : [
		'osProcess',
		'process',
		'port',
		'replicaSetName',
		'useSyslog',
		'timeout'
	],
	#classInstVars : [
		'mongodPathString'
	],
	#category : 'Mongo-Tests-ReplicaSet'
}

{ #category : #accessing }
MongoTestServer class >> mongodPathString [
	^ mongodPathString ifNil: [ '/usr/bin/mongod' ]
]

{ #category : #accessing }
MongoTestServer class >> mongodPathString: aPathAsString [
	mongodPathString := aPathAsString
]

{ #category : #examples }
MongoTestServer class >> openInWorkspace [
	<example>
	| workspace code |
	code := Character cr
		join: ((self class sourceCodeAt: #workspaceCode) lines allButFirst: 2).
	workspace := Smalltalk tools workspace openContents: code.
	workspace label: 'Example'
]

{ #category : #examples }
MongoTestServer class >> workspaceCode [
	| server |
	
	"Start"
	server := MongoTestServer new
				port: 27092;
				yourself.
	server start; waitIsWrittable.
	[[ 	[| isMaster |
		isMaster := server mongoDo: [ :mongo | mongo isMaster ].
		Transcript cr; show: isMaster localTime; cr]
			on: Error do: [ :e | e logCr ].
		1 second wait.
		] doWhileTrue: [ server isStarted ] ] fork.

	"Play"
	server sigstop. "pause"
	server sigcont. "unpause"

	"Stop"
	server ensureTerminated.
]

{ #category : #accessing }
MongoTestServer >> directoryString [
	^ '/tmp/', self portString
]

{ #category : #private }
MongoTestServer >> ensureDirectoryCreated [
	self directoryString asFileReference
		ensureDeleteAll;
		ensureCreateDirectory
]

{ #category : #'start/stop' }
MongoTestServer >> ensureStarted [
	self isStarted
		ifTrue: [ self sigcont "it may need it due to sigstop" ]
		ifFalse: [ self start ]

]

{ #category : #'start/stop' }
MongoTestServer >> ensureTerminated [
	(osProcess notNil and: [ osProcess isRunning ])
		ifTrue: [  osProcess terminate ].
	osProcess := nil.

	(process notNil and: [ process isTerminated not ])
		ifTrue: [ process terminate ].
	process := nil.
]

{ #category : #accessing }
MongoTestServer >> fullHost [
	^ 'localhost:', self portString
]

{ #category : #testing }
MongoTestServer >> hasReplicaSetName [
	^ replicaSetName isNotNil
]

{ #category : #testing }
MongoTestServer >> isStarted [
	^ osProcess notNil and: [ osProcess isRunning ]
]

{ #category : #'start/stop' }
MongoTestServer >> mongoDo: aBlock [
	| mongo |
	mongo := Mongo host: 'localhost' port: port.
	mongo openWithTimeout: self timeout.
	mongo socketTimeout: self timeout.
	^ [ aBlock value: mongo ]
		ensure: [ mongo closeIfOpen ]
]

{ #category : #private }
MongoTestServer >> mongodArguments [
	^ Array streamContents: [ :stream |
		stream
			nextPut: '--port'; nextPut: self portString;
			nextPut: '--dbpath'; nextPut: self directoryString.
		self useSyslog ifTrue: [ 
			stream nextPut: '--syslog' ].
		self hasReplicaSetName ifTrue: [ 
			stream nextPut: '--replSet'; nextPut: self replicaSetName ]
		]
]

{ #category : #private }
MongoTestServer >> newOsProcess [
	^ OSSUnixSubprocess new
		command: self class mongodPathString;
		arguments: self mongodArguments;
		redirectStdout;
		redirectStderr;
		terminateOnShutdown;
		yourself
]

{ #category : #accessing }
MongoTestServer >> port [
	^ port
]

{ #category : #accessing }
MongoTestServer >> port: aNumber [
	port := aNumber
]

{ #category : #accessing }
MongoTestServer >> portString [
	^ port asString
]

{ #category : #printing }
MongoTestServer >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: port;
		space;
		nextPutAll: (self isStarted ifTrue: 'ON' ifFalse: 'OFF');
		nextPut: $)
]

{ #category : #accessing }
MongoTestServer >> replicaSetName [
	^ replicaSetName
]

{ #category : #accessing }
MongoTestServer >> replicaSetName: aString [
	replicaSetName := aString
]

{ #category : #'start/stop' }
MongoTestServer >> runOsProcess [
	osProcess
		runAndWaitPollingEvery: (Delay forMilliseconds: 250)
		doing: [ :aProcess :outStream :errStream |  
			Transcript
				<< outStream upToEnd;
				<< errStream upToEnd.
		]
		onExitDo: [ :aProcess :outStream :errStream |
			Transcript
				<< outStream upToEnd;
				<< errStream upToEnd;
				<< '>>>> ';
				<< aProcess exitStatusInterpreter.
			aProcess closeAndCleanStreams.
		]

]

{ #category : #'start/stop' }
MongoTestServer >> sigcont [
	osProcess sigcont
]

{ #category : #'start/stop' }
MongoTestServer >> sigstop [
	osProcess sigstop
]

{ #category : #'start/stop' }
MongoTestServer >> start [
	self ensureTerminated.
	self ensureDirectoryCreated.
	osProcess := self newOsProcess.
	process := [ self runOsProcess ] forkNamed: self asString
]

{ #category : #accessing }
MongoTestServer >> timeout [
	^ timeout ifNil: [ 10 seconds ]
]

{ #category : #accessing }
MongoTestServer >> timeout: aDuration [
	timeout := aDuration
]

{ #category : #accessing }
MongoTestServer >> url [
	^ self fullHost asMongoUrl
]

{ #category : #accessing }
MongoTestServer >> useSyslog [
	^ useSyslog ifNil: [ useSyslog := true ]
]

{ #category : #accessing }
MongoTestServer >> useSyslog: aBoolean [
	useSyslog := aBoolean
]

{ #category : #operations }
MongoTestServer >> waitIsWrittable [
	| deadline |
	deadline := DateAndTime now + self timeout.
	
	[	osProcess isComplete ifTrue: [ 
			^ self error: ('Unexpected termination of mongod OS process: ', osProcess asString) ].
		[ self mongoDo: [ :mongo | ^ mongo isMaster ] ] 
			on: NetworkError
			do: [ 50 milliSeconds wait ].
	] doWhileTrue: [ DateAndTime now < deadline ].

	self error: ('Timeout waiting that {1} becomes writtable' format: { self fullHost })
]
