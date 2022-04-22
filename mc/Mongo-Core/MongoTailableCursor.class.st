"
I support a tailable cursor on a capped collection...
"
Class {
	#name : #MongoTailableCursor,
	#superclass : #Object,
	#instVars : [
		'root',
		'query',
		'cursorId'
	],
	#category : 'Mongo-Core-Utilities'
}

{ #category : #'as yet unclassified' }
MongoTailableCursor >> create [
	| op reply |
	query chunkSize: 0.
	op := QueryOperation
		id: root nextRequestID
		stream: root stream
		query: query.
	op
		flags: ((QueryOperation flagTailableCursor | QueryOperation flagAwaitData));
		write.
	reply := (ReplyOperation stream: root stream) read.
	cursorId := reply cursorId.
	reply do: query doBlock.
]

{ #category : #'as yet unclassified' }
MongoTailableCursor >> cursorId [
	^ cursorId
]

{ #category : #'as yet unclassified' }
MongoTailableCursor >> next [
	query chunkSize: 1.
	self requestNext.
	^self readNext.

]

{ #category : #'as yet unclassified' }
MongoTailableCursor >> query: anObject [
	query := anObject
]

{ #category : #'as yet unclassified' }
MongoTailableCursor >> readNext [
	| reply |
	reply := (ReplyOperation stream: root stream) read.
	reply do: query doBlock.
	^reply
]

{ #category : #'as yet unclassified' }
MongoTailableCursor >> requestNext [
	root getMore: cursorId collection: query collection qualifiedName chunkSize: query chunkSize.
]

{ #category : #'as yet unclassified' }
MongoTailableCursor >> root: anObject [
	root := anObject
]
