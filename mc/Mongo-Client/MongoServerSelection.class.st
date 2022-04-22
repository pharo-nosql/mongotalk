"
I implement the behavior defined by the mongodb's Server Selection specification.

Sources: 
* https://docs.mongodb.com/v4.0/core/read-preference-mechanics/
* https://www.mongodb.com/blog/post/server-selection-next-generation-mongodb-drivers

"
Class {
	#name : #MongoServerSelection,
	#superclass : #Object,
	#instVars : [
		'client',
		'readPreference',
		'localThreshold',
		'selectedMonitor',
		'timeoutMilliSeconds'
	],
	#category : 'Mongo-Client-Client'
}

{ #category : #'instance creation' }
MongoServerSelection class >> client: aClient [
	^ self basicNew
		initializeWithClient: aClient;
		yourself
]

{ #category : #public }
MongoServerSelection >> execute [
	"Detect a monitor that satisfy the readPreference and localThreshold, signalling MongoServerSelectionTimeout if none is found."
	
	| startMS |
	startMS := Time millisecondClockValue.
	[
		self flag: #todo. "Don't use nil as answer..."
		selectedMonitor := self readPreference accept: self.
		selectedMonitor ifNotNil: [ :monitor | ^ monitor ].

		client settings minHeartbeatFrequency wait.
		(Time millisecondsSince: startMS) >= self timeoutMilliSeconds
			ifTrue: [ ^ MongoServerSelectionTimeout signal ]

	] repeat
]

{ #category : #initialization }
MongoServerSelection >> initializeWithClient: aMongoClient [
	self initialize.
	client := aMongoClient.

]

{ #category : #accessing }
MongoServerSelection >> localThreshold [
	^ localThreshold ifNil: [ localThreshold := client settings localThreshold ]
]

{ #category : #accessing }
MongoServerSelection >> localThreshold: aDuration [
	localThreshold := aDuration
]

{ #category : #private }
MongoServerSelection >> randomEligibleMonitorOrNilIn: someMonitors [
	"Detect a monitor that satisfy the readPreference and localThreshold."
	
	| eligibleMonitors latencyWindowLowerBound latencyWindowUpperBound |
	eligibleMonitors := someMonitors.
	eligibleMonitors ifEmpty: [ ^ nil ].

	"Filter by staleness"
	self readPreference hasMaxStalenessValue ifTrue: [
		eligibleMonitors := eligibleMonitors select: [ :each |
			each staleness <= self readPreference maxStaleness ] ].
	eligibleMonitors ifEmpty: [ ^ nil ].

	"TODO: filter by tag set (https://docs.mongodb.com/v4.0/core/read-preference/#tag-set)"

	"Filter by latency window"
	latencyWindowLowerBound := (eligibleMonitors collect: [ :each | each roundtripDurationAverage ]) min.
	latencyWindowUpperBound := latencyWindowLowerBound + self localThreshold.
	eligibleMonitors := eligibleMonitors select: [ :each |
		each roundtripDurationAverage <= latencyWindowUpperBound ].
	eligibleMonitors ifEmpty: [ ^ nil ].

	"Finally, choose one."
	^ eligibleMonitors atRandom: client settings serverSelectionRandomGenerator

]

{ #category : #accessing }
MongoServerSelection >> readPreference [
	^ readPreference ifNil: [ readPreference := client settings readPreference ]
]

{ #category : #accessing }
MongoServerSelection >> readPreference: aReadPreference [
	readPreference := aReadPreference
]

{ #category : #public }
MongoServerSelection >> selectedMonitor [
	^ selectedMonitor
]

{ #category : #accessing }
MongoServerSelection >> timeoutMilliSeconds [
	^ timeoutMilliSeconds
		ifNil: [ client settings serverSelectionTimeout asMilliSeconds ]
]

{ #category : #accessing }
MongoServerSelection >> timeoutMilliSeconds: aDuration [
	^ timeoutMilliSeconds := aDuration
]

{ #category : #visiting }
MongoServerSelection >> visitNearestReadPreference: aReadPreference [
	^ self randomEligibleMonitorOrNilIn: client successfulMonitors
]

{ #category : #visiting }
MongoServerSelection >> visitPrimaryPreferedReadPreference: aReadPreference [
	^ client topology hasPrimary
		ifTrue: [ client primaryMonitor ]
		ifFalse: [ self randomEligibleMonitorOrNilIn: client successfulSecondaryMonitors ]
]

{ #category : #visiting }
MongoServerSelection >> visitPrimaryReadPreference: aReadPreference [
	^ client topology hasPrimary
		ifTrue: [ client primaryMonitor ]
		ifFalse: [ nil ]
]
