"
Check for not in (excluded)
"
Class {
	#name : #MQNotInCondition,
	#superclass : #MQComparisonCondition,
	#category : 'Mongo-Queries-Nodes-Conditions'
}

{ #category : #accessing }
MQNotInCondition >> label [
	^ '$nin'
]
