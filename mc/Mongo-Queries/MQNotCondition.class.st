"
A NOT condition

Instance Variables
	condition:		<Object>

condition
	- xxxxx

"
Class {
	#name : #MQNotCondition,
	#superclass : #MQCondition,
	#instVars : [
		'condition'
	],
	#category : 'Mongo-Queries-Nodes-Conditions'
}

{ #category : #'instance creation' }
MQNotCondition class >> condition: aCondition [
	^ self new
		condition: aCondition;
		yourself
]

{ #category : #accessing }
MQNotCondition >> condition [
	^ condition
]

{ #category : #accessing }
MQNotCondition >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
MQNotCondition >> label [
	^ '$not'
]

{ #category : #visiting }
MQNotCondition >> mqAccept: aVisitor [
	^ aVisitor visitNotCondition: self
]
