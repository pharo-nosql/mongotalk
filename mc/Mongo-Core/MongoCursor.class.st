"
A cursor for a query

Instance Variables
	query:		<Object>
	root:		<Object>

query
	- xxxxx

root
	- xxxxx

"
Class {
	#name : #MongoCursor,
	#superclass : #Object,
	#instVars : [
		'root',
		'query',
		'queryOperationFlags'
	],
	#category : 'Mongo-Core-Utilities'
}

{ #category : #'instance creation' }
MongoCursor class >> root: aMongo query: aMongoQuery [
	^self new
		root: aMongo;
		query: aMongoQuery.
]

{ #category : #executing }
MongoCursor >> execute [
	| limit reply numberReturned requestId |
	numberReturned := 0.
	limit := query limit.
	limit = 0 
		ifTrue: [limit := Float infinity ].
	limit < query chunkSize 
		ifTrue: [ query chunkSize: limit ].
	reply := nil.
	[reply isNil
		ifTrue: [ requestId := root cursorQuery: query ]
		ifFalse:
			[ requestId := root
				getMore: reply cursorId
				collection: query collection qualifiedName
				chunkSize: query chunkSize ].
	reply := (ReplyOperation stream: root stream) read.
	reply responseTo = requestId ifFalse: [
		^ MongoWireProtocolError signal: 'Unexpected responseTo in response' ].
	reply do: [:each |
		numberReturned < limit ifTrue: [
			query doBlock value: each.
			numberReturned := numberReturned + 1]].
	reply isFinished or: [ numberReturned >= limit] ] whileFalse
]

{ #category : #accessing }
MongoCursor >> query [
	^ query
]

{ #category : #accessing }
MongoCursor >> query: anObject [
	query := anObject
]

{ #category : #accessing }
MongoCursor >> root [
	^ root
]

{ #category : #accessing }
MongoCursor >> root: anObject [
	root := anObject
]
