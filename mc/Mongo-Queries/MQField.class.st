"
A field 

Instance Variables
	label:		<Object>

label
	- xxxxx

"
Class {
	#name : #MQField,
	#superclass : #MQNode,
	#instVars : [
		'label'
	],
	#category : 'Mongo-Queries-Nodes-Other'
}

{ #category : #'instance creation' }
MQField class >> labelled: aString [
	^ self new 
		initializeWithLabel: aString; 
		yourself
]

{ #category : #comparing }
MQField >> < anObject [
	^ MQLessThanCondition new
		left: self;
		right: anObject;
		yourself
]

{ #category : #comparing }
MQField >> <= anObject [
	^ MQLessThanEqualCondition new
		left: self;
		right: anObject;
		yourself
]

{ #category : #comparing }
MQField >> = anObject [
	^ MQEqualCondition new
		left: self;
		right: anObject;
		yourself
]

{ #category : #comparing }
MQField >> > anObject [
	^ MQGreaterThanCondition new
		left: self;
		right: anObject;
		yourself
]

{ #category : #comparing }
MQField >> >= anObject [
	^ MQGreaterThanEqualCondition new
		left: self;
		right: anObject;
		yourself
]

{ #category : #testing }
MQField >> in: aCollection [
	^ MQInCondition new
		left: self;
		right: aCollection;
		yourself
]

{ #category : #testing }
MQField >> includes: anObject [
	"Mongo doesn't use any special query for values in arrays"
	
	^ self = anObject
]

{ #category : #initialization }
MQField >> initializeWithLabel: aString [
	label := aString
]

{ #category : #accessing }
MQField >> label [
	^ label
]

{ #category : #comparing }
MQField >> matchesRegex: aRegExString [
	^ MQRegexCondition new
		left: self;
		right: aRegExString;
		yourself
]

{ #category : #visiting }
MQField >> mqAccept: aVisitor [
	^ aVisitor visitField: self
]

{ #category : #testing }
MQField >> notIn: aCollection [
	^ MQNotInCondition new
		left: self;
		right: aCollection;
		yourself
]

{ #category : #testing }
MQField >> size [
	^ MQSizeCondition
		new  left: self
]

{ #category : #testing }
MQField >> type [
	^ MQTypeCondition
		new  left: self
]

{ #category : #testing }
MQField >> where: aString [
	^ MQWhereCondition new
		javascript: aString;
		yourself
]

{ #category : #comparing }
MQField >> ~= anObject [
	^ MQNotEqualCondition new
		left: self;
		right: anObject;
		yourself
]
