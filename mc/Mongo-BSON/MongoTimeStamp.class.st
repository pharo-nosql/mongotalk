"
BSON has a special timestamp type for internal MongoDB use and is not associated with the regular Date type. Timestamp values are a 64 bit value where:

- the first 32 bits are a time_t value (seconds since the Unix epoch)
- the second 32 bits are an incrementing ordinal for operations within a given second.

See more on: https://docs.mongodb.org/manual/reference/bson-types/#timestamps

    Instance Variables
	value:		<an integer of 64 bits>

"
Class {
	#name : #MongoTimeStamp,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : 'Mongo-BSON-Utilities'
}

{ #category : #'instance creation' }
MongoTimeStamp class >> value: nextInt64 [
	^ self basicNew
		initialize: nextInt64;
		yourself
]

{ #category : #comparing }
MongoTimeStamp >> = other [
	^other class == self class and: [ other value = value ]
]

{ #category : #accessing }
MongoTimeStamp >> bsonTypeCode [ 
	^17
]

{ #category : #comparing }
MongoTimeStamp >> hash [
	^self class hash bitXor: value hash
]

{ #category : #initialization }
MongoTimeStamp >> initialize: aInt64 [ 
	value := aInt64.
	self initialize.
]

{ #category : #printing }
MongoTimeStamp >> printOn: aStream [ 
	aStream 
		nextPut: $/;
		nextPutAll: self value asString;
		nextPut: $/;
		nextPut: $i
]

{ #category : #accessing }
MongoTimeStamp >> value [
	^ value
]

{ #category : #writing }
MongoTimeStamp >> writeBSONOn: aBSON [ 
	aBSON nextTimestampPut: self
]
