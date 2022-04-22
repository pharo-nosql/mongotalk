"
A mongo query condition
"
Class {
	#name : #MQCondition,
	#superclass : #MQNode,
	#category : 'Mongo-Queries-Nodes-Conditions'
}

{ #category : #'logical operation' }
MQCondition >> & aCondition [
	^ MQAndCondition 
		conditions: (Array with: self with: aCondition)
]

{ #category : #visiting }
MQCondition >> mqAccept: aVisitor [
	^ aVisitor visitCondition: self
]

{ #category : #'logical operation' }
MQCondition >> not [
	^ MQNotCondition condition: self
]

{ #category : #'logical operation' }
MQCondition >> | aCondition [
	^ MQOrCondition 
		conditions: (Array with: self with: aCondition)
]
