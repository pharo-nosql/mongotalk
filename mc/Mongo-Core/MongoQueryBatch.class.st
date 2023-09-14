Class {
	#name : #MongoQueryBatch,
	#superclass : #Object,
	#instVars : [
		'documents',
		'collectionName',
		'cursorId'
	],
	#category : #'Mongo-Core-Responses'
}

{ #category : #'instance creation' }
MongoQueryBatch class >> newFromFirstBatchResponse: aDictionary [
	| cursorDictionary |

	cursorDictionary := aDictionary at: 'cursor'.
	^ self basicNew
		initializeWithCollectionName: (cursorDictionary at: 'ns')
		documents: (cursorDictionary at: 'firstBatch')
		cursorId: (cursorDictionary at: 'id');
		yourself
]

{ #category : #'instance creation' }
MongoQueryBatch class >> newFromGetMoreResponse: aDictionary [

	| cursorDictionary |
	cursorDictionary := aDictionary at: 'cursor'.
	^ self basicNew
		initializeWithCollectionName: (cursorDictionary at: 'ns')
		documents: (cursorDictionary at: 'nextBatch')
		cursorId: (cursorDictionary at: 'id');
		yourself
]

{ #category : #accessing }
MongoQueryBatch >> atEnd [
	^ self cursorId = 0
]

{ #category : #accessing }
MongoQueryBatch >> collectionName [
	^ collectionName
]

{ #category : #accessing }
MongoQueryBatch >> cursorId [
	^ cursorId
]

{ #category : #accessing }
MongoQueryBatch >> documents [
	^ documents
]

{ #category : #initialization }
MongoQueryBatch >> initializeWithCollectionName: aString documents: aCollection cursorId: anInteger [

	self initialize.
	self flag: #todo. "This code removes the db name, and it's a bit strange to have it here."
	collectionName := aString readStream upTo: $.; upToEnd.
	documents := aCollection.
	cursorId := anInteger
]
