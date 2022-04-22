"
Selects the documents where the value of the field is an instance of the specified numeric BSON type
"
Class {
	#name : #MQTypeCondition,
	#superclass : #MQComparisonCondition,
	#category : 'Mongo-Queries-Nodes-Conditions'
}

{ #category : #comparing }
MQTypeCondition >> = anInteger [
	anInteger isInteger ifFalse: [ MQQueryError signal: 'BSON type must be an Integer'].
	
	self right: anInteger
]

{ #category : #accessing }
MQTypeCondition >> label [
	^ '$type'
]
