"
I am a client inspired in the MongoDB specification.

See: https://github.com/mongodb/specifications/

"
Class {
	#name : #MongoClient,
	#superclass : #Object,
	#instVars : [
		'monitors',
		'topology',
		'announcer',
		'topologyMutex',
		'settings'
	],
	#classVars : [
		'PRIMARY_READ_PREFERENCE'
	],
	#category : 'Mongo-Client-Client'
}

{ #category : #'class initialization' }
MongoClient class >> initialize [
	PRIMARY_READ_PREFERENCE := MongoReadPreference newPrimary
]

{ #category : #'instance creation' }
MongoClient class >> withUrls: aCollection [
	^ self basicNew
		initializeWith: aCollection;
		yourself
]

{ #category : #private }
MongoClient >> addMonitorsForAll: newUrlStrings andDo: aBlockClosure [
	newUrlStrings do: [ :each | 
		| newMonitor initialServerDescription |
		initialServerDescription := MongoUnknownServerDescription urlString: each.
		topology basicServerAt: each put: initialServerDescription.
		newMonitor := MongoMonitor
			urlString: each
			client: self
			initialServerDescription: initialServerDescription.
		monitors at: each put: newMonitor.
		aBlockClosure cull: newMonitor ]
]

{ #category : #private }
MongoClient >> announceIfNeeded: aBlockThatValuesToAnAnnouncement [
	self shouldAnnounce ifTrue: [
		announcer announce: aBlockThatValuesToAnAnnouncement value ]
]

{ #category : #accessing }
MongoClient >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #private }
MongoClient >> discoverUrlsFrom: urlsAsStrings [
	"MongoDB specs state that hosts must not be removed from the list of known hosts: any host may dissapear temporarily only.
	Note 1: This method assumes discovery is performed when monitors are started, then it starts any new monitor.
	Note 2: Caller must ensure in critical region."

	(urlsAsStrings difference: topology serversUrlStrings) ifNotEmpty: [ :newUrlsAsStrings |
		self addMonitorsForAll: newUrlsAsStrings andDo: #start ].

]

{ #category : #private }
MongoClient >> handleConnectionError: anError on: selectedMonitor [
	"React (internally) to connection error and then pass the error to the external handler."
	
	selectedMonitor handleConnectionError: anError.
	anError pass
]

{ #category : #private }
MongoClient >> handleMongoQueryOrCommandError: aMongoQueryOrCommandError on: selectedMonitor [
	"Handles an error happened during the execution of a query or command."

	aMongoQueryOrCommandError isNotMasterAndSlaveOkIsFalse ifTrue: [
		"Common case: the primary server changed to secondary"
		selectedMonitor
			latestServerDescription:
				(MongoErrorServerDescription
					urlString: aMongoQueryOrCommandError signaler urlString
					errorDescription: aMongoQueryOrCommandError description) ].

	aMongoQueryOrCommandError pass
]

{ #category : #initialization }
MongoClient >> initializeWith: initialUrls [
	| initialUrlStrings |
	self initialize.

	topologyMutex := Mutex new.
	monitors := Dictionary new.
	topology := MongoTopology new.
	settings := MongoClientSettings for: self.

	initialUrlStrings := initialUrls collect: [:each | each asMongoUrl asMongoUrlString ].
	self
		addMonitorsForAll: initialUrlStrings
		andDo: [].

]

{ #category : #testing }
MongoClient >> isMonitoringSteadyState [
	^ topology isTypeReplicaSetWithPrimary or: [ topology isTypeSingle ]
]

{ #category : #testing }
MongoClient >> isStarted [
	^ monitors allSatisfy: [ :each | each isStarted ]
]

{ #category : #API }
MongoClient >> mongoDo: aBlockClosure [
	"Evaluate aBlockClosure with a Mongo instance selected using the default parameters."

	^ self
		mongoDo: aBlockClosure
		serverSelection: self newServerSelection
]

{ #category : #API }
MongoClient >> mongoDo: aBlockClosure readPreference: aReadPreference [
	"Evaluate aBlockClosure with a Mongo instance selected using aReadPreference instead of the default parameter."

	^ self
		mongoDo: aBlockClosure
		serverSelection: (self newServerSelection
			readPreference: aReadPreference;
			yourself)

]

{ #category : #API }
MongoClient >> mongoDo: aBlockClosure readPreference: aReadPreference localThreshold: localThresholdDuration [
	"Evaluate aBlockClosure with a Mongo instance selected using aReadPreference and localThresholdDuration instead of the default parameters."

	^ self
		mongoDo: aBlockClosure
		serverSelection: (self newServerSelection
			readPreference: aReadPreference;
			localThreshold: localThresholdDuration;
			yourself)

]

{ #category : #API }
MongoClient >> mongoDo: aBlockClosure serverSelection: aMongoServerSelection [
	"Evaluate aBlockClosure with a Mongo instance selected using the parameters setted in aMongoServerSelection."

	| selectedMonitor |
	selectedMonitor := aMongoServerSelection execute; selectedMonitor.

	^ [ [ selectedMonitor pool mongoDo: aBlockClosure ]
		on: MongoCommandError, MongoQueryError do: [ :error |
			self handleMongoQueryOrCommandError: error on: selectedMonitor ] ]
		on: NetworkError, MongoWireProtocolError do: [ :error |
			self handleConnectionError: error on: selectedMonitor ]
]

{ #category : #accessing }
MongoClient >> monitoringFrequency [
	^ self isMonitoringSteadyState
		ifTrue: [ settings heartbeatFrequency ]
		ifFalse: [ settings minHeartbeatFrequency ]
]

{ #category : #accessing }
MongoClient >> monitors [
	^ monitors
]

{ #category : #private }
MongoClient >> newServerSelection [
	^ MongoServerSelection client: self
]

{ #category : #API }
MongoClient >> primaryMongoDo: aBlockClosure [
	"Evaluate aBlockClosure with a 'primary' Mongo instance."

	^ self
		mongoDo: aBlockClosure
		readPreference: PRIMARY_READ_PREFERENCE

]

{ #category : #accessing }
MongoClient >> primaryMonitor [
	^ monitors at: topology primaryUrlString
]

{ #category : #printing }
MongoClient >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream nextPut: $(.
	self printStatusOn: aStream.
	aStream nextPut: $)
]

{ #category : #printing }
MongoClient >> printStatusOn: aStream [

	| numberOfStartedMonitors totalServers |
	numberOfStartedMonitors := monitors count: #isStarted.
	totalServers := topology numberOfServers.
	
	aStream
		nextPutAll: 'ON:';
		print: numberOfStartedMonitors;
		nextPutAll: ';OFF:';
		print: totalServers - numberOfStartedMonitors.

]

{ #category : #private }
MongoClient >> refreshTopologyWith: newServerDescription [

	topologyMutex critical: [
		| latestServerDescription oldTopology |
		latestServerDescription := topology serverAt: newServerDescription urlString.
		(self shouldAnnounce and: [ newServerDescription hasDifferenceWith: latestServerDescription ]) 
			ifTrue: [ announcer announce: 
				(MongoServerDescriptionUpdate
					from: latestServerDescription
					to: newServerDescription) ].
		
		oldTopology := topology.
		topology := MongoTopology
			newBasedOn: topology
			updatedWith: newServerDescription.

		(newServerDescription isSuccess and: [ newServerDescription isMaster isReplicaSet ])
			ifTrue: [ 
				self discoverUrlsFrom: newServerDescription isMaster replicaSetHosts.
				self discoverUrlsFrom: newServerDescription isMaster replicaSetPassives ].

		(self shouldAnnounce and: [ topology hasDifferenceWith: oldTopology ])
			ifTrue: [ announcer announce:
				(MongoTopologyUpdate from: oldTopology to: topology) ].
	].
]

{ #category : #accessing }
MongoClient >> settings [
	^ settings
]

{ #category : #testing }
MongoClient >> shouldAnnounce [
	^ announcer notNil and: [ announcer numberOfSubscriptions > 0 ]
]

{ #category : #API }
MongoClient >> start [
	monitors valuesDo: #start.

]

{ #category : #API }
MongoClient >> stop [
	monitors valuesDo: [ :each |
		each isRunning ifTrue: [
			each stop waitForCompletion: settings monitorStopTimeout ] ].

]

{ #category : #accessing }
MongoClient >> successfulMonitors [
	^ monitors select: [ :each |
		each latestServerDescription isSuccess ]
]

{ #category : #accessing }
MongoClient >> successfulSecondaryMonitors [
	^ monitors select: [ :each |
		each latestServerDescription isSuccess and: [
		each latestServerDescription isSecondary ] ]

]

{ #category : #accessing }
MongoClient >> topology [
	^ topology
]

{ #category : #private }
MongoClient >> updatedPoolSettings [
	monitors do: [ :each | each pool resetAll ]
]
