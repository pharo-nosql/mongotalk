"
I represent the description of a mongodb server. The main information I provide is extracted from a mongodb's ismaster command, but I also know the roundtrip time to get such answer from the server.
"
Class {
	#name : #MongoServerDescription,
	#superclass : #MongoAbstractServerDescription,
	#instVars : [
		'isMaster',
		'roundtripDurationAverage'
	],
	#category : 'Mongo-Client-Topology'
}

{ #category : #'instance creation' }
MongoServerDescription class >> urlString: urlString isMaster: aMongoIsMaster roundtripTime: aDuration [
	^ self basicNew
		initializeUrlString: urlString
			isMaster: aMongoIsMaster
			roundtripDurationAverage: aDuration;
		yourself
]

{ #category : #accessing }
MongoServerDescription >> differencesFrom: anotherMongoServerDescription do: aBlockClosure [

	"If there is a diff in super, stop here."
	super differencesFrom: anotherMongoServerDescription do: [:selector :diff |
		^ aBlockClosure cull: selector cull: diff ].

	"Then, check diff in isMaster response."
	self isMaster
		differencesFrom: anotherMongoServerDescription isMaster
		do: aBlockClosure

]

{ #category : #initialization }
MongoServerDescription >> initializeUrlString: aUrlString isMaster: aMongoIsMaster roundtripDurationAverage: aDuration [
	self initializeUrlString: aUrlString.
	isMaster := aMongoIsMaster.
	roundtripDurationAverage := aDuration
]

{ #category : #accessing }
MongoServerDescription >> isMaster [
	^ isMaster
]

{ #category : #testing }
MongoServerDescription >> isSecondary [
	^ isMaster isSecondary
]

{ #category : #testing }
MongoServerDescription >> isSuccess [
	^ true
]

{ #category : #printing }
MongoServerDescription >> printOn: aStream [
	super printOn: aStream.

	aStream nextPutAll: ':'; cr.
	#(isSecondary staleness) do: [ :each |
		aStream
			tab;
			nextPutAll: each;
			nextPutAll: ': ';
			print: (self perform: each);
			cr ].
	
	

]

{ #category : #accessing }
MongoServerDescription >> roundtripDurationAverage [
	^ roundtripDurationAverage
]

{ #category : #accessing }
MongoServerDescription >> staleness [
	^ isMaster isReplicaSet
		ifTrue: [ isMaster staleness ]
		ifFalse: [ 0 seconds ]
]
