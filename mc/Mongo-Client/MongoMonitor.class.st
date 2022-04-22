"
I am a monitor that tracks the status of a MongoDB server.

I am a key collaborator for instances of MongoClient.
"
Class {
	#name : #MongoMonitor,
	#superclass : #TKTService,
	#instVars : [
		'client',
		'roundtripTimeCalculator',
		'urlString',
		'nextTimeToCheck',
		'pool',
		'latestServerDescription',
		'mongo'
	],
	#category : 'Mongo-Client-Client'
}

{ #category : #'instance creation' }
MongoMonitor class >> urlString: urlString client: aMongoClient initialServerDescription: aMongoServerDescription [
	^ self basicNew
		initializeUrlString: urlString
			client: aMongoClient
			initialServerDescription: aMongoServerDescription;
		yourself
]

{ #category : #private }
MongoMonitor >> checkOnce [
	"Heatbeat: Perform a single attempt to call ismaster, and handle either success or failure."

	[ self ensureMongoIsOpened.
	self doCheckAndHandleSuccess ]
		on: NetworkError, MongoWireProtocolError
		do: [ :error |
			self ensureMongoIsClosed.
			self handleHeatbeatError: error ]
]

{ #category : #private }
MongoMonitor >> doCheckAndHandleSuccess [

	| response roundtripDuration |
	client announceIfNeeded: [
		MongoHeartbeatStarted urlString: urlString ].

	roundtripDuration := [ response := mongo isMaster ] timeToRun.

	self handleHeatbeatSuccess: response for: roundtripDuration.
]

{ #category : #private }
MongoMonitor >> ensureMongoIsClosed [
	mongo closeIfOpen
]

{ #category : #private }
MongoMonitor >> ensureMongoIsOpened [
	"Spec: 'Socket timeout for monitoring is connectTimeoutMS'"

	mongo isOpen ifFalse: [
		mongo
			openWithTimeout: client settings connectTimeout;
			socketTimeout: client settings connectTimeout ]
]

{ #category : #accessing }
MongoMonitor >> handleConnectionError: anError [
	"React to a connection error to a server. This includes both heatbeat and
	command connections.
	When a server goes down, this methods may be evaluated many times (one
	for each ongoing command + one for a heatbeat), but will consider only first."

	latestServerDescription isError ifTrue: [ ^ self ].
	
	roundtripTimeCalculator reset.

	self latestServerDescription:
		(MongoErrorServerDescription
			urlString: urlString
			errorDescription: anError description)
]

{ #category : #private }
MongoMonitor >> handleHeatbeatError: anError [
	"React to a heatbeat failure."

	client announceIfNeeded: [
		MongoHeartbeatFailed
			urlString: urlString
			errorDescription: anError description ].

	self handleConnectionError: anError.
]

{ #category : #accessing }
MongoMonitor >> handleHeatbeatSuccess: isMasterResponse for: roundtripDuration [
	client announceIfNeeded: [
		MongoHeartbeatSucceeded 
			urlString: urlString
			roundtripTimeDuraton: roundtripDuration
			isMaster: isMasterResponse ].

	roundtripTimeCalculator add: roundtripDuration asMilliSeconds.

	self latestServerDescription:
		(MongoServerDescription
			urlString: urlString
			isMaster: isMasterResponse
			roundtripTime: self roundtripDurationAverage)
]

{ #category : #initialization }
MongoMonitor >> initializeUrlString: aUrlString client: aMongoClient initialServerDescription: aMongoServerDescription [
	self initialize.

	urlString := aUrlString.
	client := aMongoClient.
	latestServerDescription := aMongoServerDescription.
	roundtripTimeCalculator := MongoMovingAverageCalculator new.

	pool := MongoPool
		url: urlString asMongoUrl
		settings: client settings.

	"Spec: 'Servers are monitored with dedicated sockets'"
	mongo := Mongo url: urlString asMongoUrl.

]

{ #category : #testing }
MongoMonitor >> isStarted [
	^ self isRunning
]

{ #category : #accessing }
MongoMonitor >> latestServerDescription [
	^ latestServerDescription
]

{ #category : #accessing }
MongoMonitor >> latestServerDescription: aServerDescription [
	latestServerDescription := aServerDescription.
	client refreshTopologyWith: latestServerDescription
]

{ #category : #accessing }
MongoMonitor >> name [
	^ 'Monitor {1} - client {2}'
		format:
			{urlString.
			client identityHash}
]

{ #category : #accessing }
MongoMonitor >> pool [
	^ pool
]

{ #category : #printing }
MongoMonitor >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: urlString;
		space;
		print: self isStarted;
		nextPut: $).

]

{ #category : #accessing }
MongoMonitor >> roundtripDurationAverage [
	^ roundtripTimeCalculator average milliSeconds
]

{ #category : #accessing }
MongoMonitor >> staleness [
	^ latestServerDescription isSuccess
		ifTrue: [ latestServerDescription staleness ]
		ifFalse: [ self error: 'Cannot know' ]

]

{ #category : #stepping }
MongoMonitor >> stepService [
	"Check server and inform response"
	self checkOnce.

	"Update time"
	self stepDelay: client monitoringFrequency.

]

{ #category : #accessing }
MongoMonitor >> tearDown [
	self ensureMongoIsClosed.
	pool resetAll.
]

{ #category : #accessing }
MongoMonitor >> urlString [
	^ urlString
]
