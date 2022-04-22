"
Check for less than equal
"
Class {
	#name : #MQLessThanEqualCondition,
	#superclass : #MQComparisonCondition,
	#category : 'Mongo-Queries-Nodes-Conditions'
}

{ #category : #accessing }
MQLessThanEqualCondition >> label [
	^ '$lte'
]
