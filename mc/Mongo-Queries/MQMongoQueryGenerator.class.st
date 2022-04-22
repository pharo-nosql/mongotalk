"
A query generator
"
Class {
	#name : #MQMongoQueryGenerator,
	#superclass : #MQVisitor,
	#category : 'Mongo-Queries-Utilities'
}

{ #category : #visiting }
MQMongoQueryGenerator >> visitComparisonCondition: aCondition [
	^ Dictionary new 
		at: (self visit: aCondition left) 
		put: (Dictionary new
			at: aCondition label
			put: (self visit: aCondition right);
			yourself);
		yourself
]

{ #category : #visiting }
MQMongoQueryGenerator >> visitEqualCondition: aCondition [
	^ Dictionary new 
		at: (self visit: aCondition left) 
		put: (self visit: aCondition right);
		yourself
]

{ #category : #visiting }
MQMongoQueryGenerator >> visitField: aField [
	^ aField label
]

{ #category : #visiting }
MQMongoQueryGenerator >> visitInCondition: aCondition [
	^ Dictionary new
		at: aCondition label
		put: (Dictionary new
			at: (self visit: aCondition left) 
			put: (self visit: aCondition right);
			yourself);
		yourself
]

{ #category : #visiting }
MQMongoQueryGenerator >> visitLogicalCondition: aLogicalCondition [
	^ Dictionary new
		at: aLogicalCondition label
		put: (aLogicalCondition conditions collect: [ :each |
			self visit: each ]);
		yourself
]

{ #category : #visiting }
MQMongoQueryGenerator >> visitNotCondition: aCondition [ 
	^ Dictionary new
		at: (self visit: aCondition condition left)
		put: (Dictionary new
			at: aCondition label
			put: (self visit: aCondition condition right);
			yourself);
		yourself
]

{ #category : #visiting }
MQMongoQueryGenerator >> visitObject: anObject [
	^ anObject
]

{ #category : #visiting }
MQMongoQueryGenerator >> visitWhereCondition: aWhereCondition [ 
	^ Dictionary new
		at: aWhereCondition label
		put: aWhereCondition javascript;
		yourself
]
