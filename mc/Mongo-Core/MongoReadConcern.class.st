"
I represent a MongoDB read concern. 

The readConcern option allows you to control the consistency and isolation properties of the data read from replica sets and replica set shards.

Through the effective use of write concerns and read concerns, you can adjust the level of consistency and availability guarantees as appropriate, such as waiting for stronger consistency guarantees, or loosening consistency requirements to provide higher availability.

Possible read concern levels are:
	* 'local'
	* 'available'
	* 'majority'
	* 'linearizable
	* 'snapshot'

See more: https://docs.mongodb.com/v4.0/reference/read-concern/



"
Class {
	#name : #MongoReadConcern,
	#superclass : #Object,
	#instVars : [
		'dictionary'
	],
	#classInstVars : [
		'local',
		'available',
		'majority',
		'linearizable',
		'snapshot'
	],
	#category : 'Mongo-Core-Utilities'
}

{ #category : #accessing }
MongoReadConcern class >> available [
	^ available ifNil: [ available := self newWithLevel: 'available' ]
]

{ #category : #accessing }
MongoReadConcern class >> linearizable [
	^ linearizable ifNil: [ linearizable := self newWithLevel: 'linearizable' ]
]

{ #category : #accessing }
MongoReadConcern class >> local [
	^ local ifNil: [ local := self newWithLevel: 'local' ]
]

{ #category : #accessing }
MongoReadConcern class >> majority [
	^ majority ifNil: [ majority := self newWithLevel: 'majority' ]
]

{ #category : #'instance c' }
MongoReadConcern class >> newWithLevel: aString [
	^ self basicNew
		initializeWithLevel: aString;
		yourself
]

{ #category : #accessing }
MongoReadConcern class >> snapshot [
	^ snapshot ifNil: [ snapshot := self newWithLevel: 'snapshot' ]
]

{ #category : #converting }
MongoReadConcern >> concernForCommand [
	^ dictionary
]

{ #category : #accessing }
MongoReadConcern >> initializeWithLevel: aString [
	self initialize.
	dictionary := Dictionary new
		at: 'level' put: aString;
		yourself
]

{ #category : #accessing }
MongoReadConcern >> level [
	"Answer the read concern level"

	^ dictionary at: 'level'
]
