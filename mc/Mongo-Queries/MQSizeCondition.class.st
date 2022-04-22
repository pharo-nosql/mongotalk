"
Matches any array with the number of elements 
"
Class {
	#name : #MQSizeCondition,
	#superclass : #MQComparisonCondition,
	#category : 'Mongo-Queries-Nodes-Conditions'
}

{ #category : #comparing }
MQSizeCondition >> = anInteger [
	anInteger isInteger ifFalse: [ MQQueryError signal: 'Array size must be an Integer'].
	
	self right: anInteger
]

{ #category : #accessing }
MQSizeCondition >> label [
	^ '$size'
]
