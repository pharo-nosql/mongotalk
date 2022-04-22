"
A where condition

Instance Variables
	javascript:		<Object>

javascript
	- xxxxx

"
Class {
	#name : #MQWhereCondition,
	#superclass : #MQCondition,
	#instVars : [
		'javascript'
	],
	#category : 'Mongo-Queries-Nodes-Conditions'
}

{ #category : #'instance creation' }
MQWhereCondition class >> javascript: aString [
	^ self new
		javascript: aString;
		yourself
]

{ #category : #accessing }
MQWhereCondition >> javascript [
	^ javascript
]

{ #category : #accessing }
MQWhereCondition >> javascript: anObject [
	javascript := anObject
]

{ #category : #accessing }
MQWhereCondition >> label [
	^ '$where'
]

{ #category : #visiting }
MQWhereCondition >> mqAccept: aVisitor [
	^ aVisitor visitWhereCondition: self
]
