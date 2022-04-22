"
I describe the state of mongodb servers in certain moment, and can determine what server can be used for read and write operations.


Source:

https://github.com/mongodb/specifications/blob/f810e051a77edbb91540c06bd8596387f7eefcbd/source/server-discovery-and-monitoring/server-discovery-and-monitoring-monitoring.rst
"
Class {
	#name : #MongoTopology,
	#superclass : #Object,
	#instVars : [
		'type',
		'primaryUrlString',
		'secondaryUrlStrings',
		'serversByUrlString'
	],
	#category : 'Mongo-Client-Topology'
}

{ #category : #'instance creation' }
MongoTopology class >> newBasedOn: aMongoTopology updatedWith: aMongoServerDescription [
	^ self basicNew
		initializeBasedOn: aMongoTopology
			updatedWith: aMongoServerDescription;
		yourself
]

{ #category : #initialization }
MongoTopology >> basicServerAt: urlString put: aMongoServerDescription [
	"Mutate this instance with aMongoServerDescription. Only use during initialization since the topology should be immutable."

	^ serversByUrlString at: urlString put: aMongoServerDescription
]

{ #category : #accessing }
MongoTopology >> differencesFrom: anotherMongoTopology do: aBlockClosure [

	#(type primaryUrlString secondaryUrlStrings) do: [ :each | 
		| mine theirs |
		mine := self perform: each.
		theirs := anotherMongoTopology perform: each.
		mine = theirs ifFalse: [ aBlockClosure cull: each cull: theirs -> mine ] ]
]

{ #category : #testing }
MongoTopology >> hasDifferenceWith: anotherMongoIsMaster [
	self differencesFrom: anotherMongoIsMaster do: [ ^ true ].
	^ false
]

{ #category : #testing }
MongoTopology >> hasDifferencesInPrimaryUrlFrom: newServerDescription [

	newServerDescription isSuccess ifFalse: [ ^false ].

	self hasPrimary ~= newServerDescription isMaster hasPrimary ifTrue: [ ^true ].
	(self hasPrimary and: [ self primaryUrlString ~= newServerDescription isMaster primaryUrlString ])
		ifTrue: [ ^true ].

	^ false
]

{ #category : #testing }
MongoTopology >> hasPrimary [
	^ primaryUrlString notNil and: [ (self serverAt: primaryUrlString) isSuccess ]
]

{ #category : #testing }
MongoTopology >> hasWritableServer [
	"Determines if the topology has a writable server available."

	^ self hasPrimary
]

{ #category : #initialization }
MongoTopology >> initialize [
	super initialize.
	
	type := MongoTopologyType unknown.
	serversByUrlString := Dictionary new.
	secondaryUrlStrings := #().
	primaryUrlString := nil.
]

{ #category : #initialization }
MongoTopology >> initializeBasedOn: anotherMongoTopology updatedWith: aMongoServerDescription [

	"Never loose some information from past topologies."
	serversByUrlString := anotherMongoTopology serversByUrlString deepCopy.
	serversByUrlString
		at: aMongoServerDescription urlString
		put: aMongoServerDescription.

	aMongoServerDescription isSuccess
		ifTrue: [ self updateWithIsMasterResponseFrom: aMongoServerDescription ]
		ifFalse: [ self overcomeErrorBasedOn: anotherMongoTopology updatedWith: aMongoServerDescription ]

]

{ #category : #accessing }
MongoTopology >> isTypeReplicaSetNoPrimary [
	^ type = MongoTopologyType replicaSetNoPrimary
]

{ #category : #accessing }
MongoTopology >> isTypeReplicaSetWithPrimary [
	^ type = MongoTopologyType replicaSetWithPrimary
]

{ #category : #accessing }
MongoTopology >> isTypeSharded [
	^ type = MongoTopologyType sharded
]

{ #category : #accessing }
MongoTopology >> isTypeSingle [
	^ type = MongoTopologyType single
]

{ #category : #accessing }
MongoTopology >> isTypeUnknown [
	^ type = MongoTopologyType unknown
]

{ #category : #accessing }
MongoTopology >> numberOfServers [
	^ serversByUrlString size
]

{ #category : #initialization }
MongoTopology >> overcomeErrorBasedOn: anotherMongoTopology updatedWith: aMongoServerDescription [

	aMongoServerDescription urlString = anotherMongoTopology primaryUrlString
		ifTrue: [
			type := MongoTopologyType replicaSetNoPrimary.
			primaryUrlString := nil ]
		ifFalse: [ 
			"Keep main status if it was an error with a secondary server."
			type := anotherMongoTopology type.
			primaryUrlString := anotherMongoTopology primaryUrlString ].
	
	"In any case, keep secondaries."
	secondaryUrlStrings := anotherMongoTopology secondaryUrlStrings.
]

{ #category : #accessing }
MongoTopology >> primaryUrl [
	^ primaryUrlString asMongoUrl
]

{ #category : #accessing }
MongoTopology >> primaryUrlString [
	^ primaryUrlString
]

{ #category : #printing }
MongoTopology >> printOn: aStream [
	super printOn: aStream.
	
	aStream nextPutAll: ': '; cr.
	#(type primaryUrlString secondaryUrlStrings) do: [ :each |
		aStream
			tab;
			nextPutAll: each;
			nextPutAll: ': ';
			print: (self perform: each);
			cr ].
	
	

]

{ #category : #accessing }
MongoTopology >> secondaryUrlStrings [
	^ secondaryUrlStrings
]

{ #category : #accessing }
MongoTopology >> secondaryUrls [
	^ secondaryUrlStrings collect: #asMongoUrl
]

{ #category : #accessing }
MongoTopology >> serverAt: urlString [
	^ serversByUrlString at: urlString
]

{ #category : #accessing }
MongoTopology >> servers [
	^ serversByUrlString values
]

{ #category : #accessing }
MongoTopology >> serversByUrlString [
	^ serversByUrlString
]

{ #category : #accessing }
MongoTopology >> serversUrlStrings [
	^ serversByUrlString keys
]

{ #category : #accessing }
MongoTopology >> type [
	^ type
]

{ #category : #initialization }
MongoTopology >> updateWithIsMasterResponseFrom: aMongoServerDescription [
	| isMaster |
	isMaster := aMongoServerDescription isMaster.

	isMaster isSharded ifTrue: [ self shouldBeImplemented ].

	isMaster isReplicaSet ifFalse: [
		type := MongoTopologyType single.
		primaryUrlString := aMongoServerDescription urlString.
		^ self ].

	isMaster hasPrimary
		ifTrue: [
			type := MongoTopologyType replicaSetWithPrimary.
			primaryUrlString := isMaster primaryUrlString ]
		ifFalse: [ 
			type := MongoTopologyType replicaSetNoPrimary.
			primaryUrlString := nil ].

	secondaryUrlStrings := Array streamContents: [ :stream |
		| block |
		block := [ :each | each = primaryUrlString ifFalse: [ stream nextPut: each ] ].
		isMaster replicaSetHosts do: block.
		isMaster replicaSetPassives do: block. ].

]
