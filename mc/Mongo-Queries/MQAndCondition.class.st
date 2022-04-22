"
An AND condition
"
Class {
	#name : #MQAndCondition,
	#superclass : #MQLogicalCondition,
	#category : 'Mongo-Queries-Nodes-Conditions'
}

{ #category : #'logical operation' }
MQAndCondition >> & aCondition [
	^ MQAndCondition conditions: self conditions, { aCondition }
]

{ #category : #accessing }
MQAndCondition >> label [
	^ '$and'
]

{ #category : #'logical operation' }
MQAndCondition >> not [
	^ self copy 
		conditions: (self conditions collect: [ :each | each not ]);
		yourself
]
