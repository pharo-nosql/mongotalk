"
Check for equal
"
Class {
	#name : #MQEqualCondition,
	#superclass : #MQComparisonCondition,
	#category : 'Mongo-Queries-Nodes-Conditions'
}

{ #category : #accessing }
MQEqualCondition >> label [
	^ '='
]

{ #category : #visiting }
MQEqualCondition >> mqAccept: aVisitor [
	^ aVisitor visitEqualCondition: self
]

{ #category : #'logical operation' }
MQEqualCondition >> not [
	"see http://www.mongodb.org/display/DOCS/Advanced+Queries#AdvancedQueries-Metaoperator%3A{{%24not}}"
	
	^ MQNotEqualCondition left: self left right: self right
]
