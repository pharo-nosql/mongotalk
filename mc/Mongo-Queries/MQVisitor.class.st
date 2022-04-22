"
A visitor to build queries
"
Class {
	#name : #MQVisitor,
	#superclass : #Object,
	#category : 'Mongo-Queries-Utilities'
}

{ #category : #visiting }
MQVisitor >> visit: anObject [
	^ anObject mqAccept: self
]

{ #category : #visiting }
MQVisitor >> visitComparisonCondition: aMQCondition [
	^ self visitCondition: aMQCondition
]

{ #category : #visiting }
MQVisitor >> visitCondition: aMQCondition [
	^ self visitNode: aMQCondition
]

{ #category : #visiting }
MQVisitor >> visitEqualCondition: aMQCondition [
	^ self visitComparisonCondition: aMQCondition
]

{ #category : #visiting }
MQVisitor >> visitField: aField [
	^ self visitNode: aField
]

{ #category : #visiting }
MQVisitor >> visitLogicalCondition: aLogicalCondition [
	^ self visitCondition: aLogicalCondition 
]

{ #category : #visiting }
MQVisitor >> visitNode: aMQNode [
	^ self visitObject: aMQNode
]

{ #category : #visiting }
MQVisitor >> visitNotCondition: aMQNotCondition [
	^ self visitCondition: aMQNotCondition
]

{ #category : #visiting }
MQVisitor >> visitObject: anObject [
]

{ #category : #visiting }
MQVisitor >> visitWhereCondition: aWhereCondition [
	^ self visitCondition: aWhereCondition 
]
