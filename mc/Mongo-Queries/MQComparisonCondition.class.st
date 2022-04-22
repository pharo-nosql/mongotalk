"
Comparision condition

Instance Variables
	left:		<Object>
	right:		<Object>

left
	- xxxxx

right
	- xxxxx

"
Class {
	#name : #MQComparisonCondition,
	#superclass : #MQCondition,
	#instVars : [
		'left',
		'right'
	],
	#category : 'Mongo-Queries-Nodes-Conditions'
}

{ #category : #'instance creation' }
MQComparisonCondition class >> left: aField right: anotherField [
	^ self new
		left: aField;
		right: anotherField;
		yourself
]

{ #category : #accessing }
MQComparisonCondition >> left [
	^ left
]

{ #category : #accessing }
MQComparisonCondition >> left: anObject [
	left := anObject
]

{ #category : #visiting }
MQComparisonCondition >> mqAccept: aVisitor [
	^ aVisitor visitComparisonCondition: self
]

{ #category : #accessing }
MQComparisonCondition >> right [
	^ right
]

{ #category : #accessing }
MQComparisonCondition >> right: anObject [
	right := anObject
]
