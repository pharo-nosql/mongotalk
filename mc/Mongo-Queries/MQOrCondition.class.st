"
An OR condition
"
Class {
	#name : #MQOrCondition,
	#superclass : #MQLogicalCondition,
	#category : 'Mongo-Queries-Nodes-Conditions'
}

{ #category : #accessing }
MQOrCondition >> label [
	^ '$or'
]

{ #category : #'logical operation' }
MQOrCondition >> not [
	^ MQNorCondition conditions: self conditions
]

{ #category : #'logical operation' }
MQOrCondition >> | aCondition [
	^ MQOrCondition conditions: self conditions, { aCondition }
]
