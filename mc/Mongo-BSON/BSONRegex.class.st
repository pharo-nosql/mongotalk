"
A BSON regexpression

Instance Variables
	value:		<Object>

value
	- xxxxx

"
Class {
	#name : #BSONRegex,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : 'Mongo-BSON-Utilities'
}

{ #category : #'instance creation' }
BSONRegex class >> value: aString [
	^self basicNew 
		initialize: aString;
		yourself
]

{ #category : #accessing }
BSONRegex >> bsonTypeCode [ 
	^11
]

{ #category : #initialization }
BSONRegex >> initialize: aString [ 
	value := aString.
	self initialize
]

{ #category : #printing }
BSONRegex >> printOn: aStream [ 
	aStream 
		nextPut: $/;
		nextPutAll: self value;
		nextPut: $/;
		nextPut: $i
]

{ #category : #accessing }
BSONRegex >> value [ 
	^value
]

{ #category : #writing }
BSONRegex >> writeBSONOn: aBSON [ 
	aBSON nextRegexPut: self
]
