"
A mongo query node
"
Class {
	#name : #MQNode,
	#superclass : #Object,
	#category : 'Mongo-Queries-Nodes-Other'
}

{ #category : #accessing }
MQNode >> label [
	self subclassResponsibility 
]

{ #category : #visiting }
MQNode >> mqAccept: aVisitor [
	^ aVisitor visitNode: self
]
