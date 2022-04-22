"
A logical condition

Instance Variables
	conditions:		<Object>

conditions
	- xxxxx

"
Class {
	#name : #MQLogicalCondition,
	#superclass : #MQCondition,
	#instVars : [
		'conditions'
	],
	#category : 'Mongo-Queries-Nodes-Conditions'
}

{ #category : #'instance creation' }
MQLogicalCondition class >> condition: aCondition [
	^ self new
		condition: aCondition;
		yourself
]

{ #category : #'instance creation' }
MQLogicalCondition class >> conditions: aCollection [
	^ self new
		conditions: aCollection;
		yourself
]

{ #category : #accessing }
MQLogicalCondition >> conditions [
	^ conditions
]

{ #category : #accessing }
MQLogicalCondition >> conditions: aCollection [
	conditions := aCollection
]

{ #category : #visiting }
MQLogicalCondition >> mqAccept: aVisitor [
	^ aVisitor visitLogicalCondition: self
]
