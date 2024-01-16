"
A command that executes an operation in mongo.
"
Class {
	#name : #MongoCursorLegacy,
	#superclass : #MongoCursor,
	#category : #'Mongo-DriverLegacy-Base'
}

{ #category : #executing }
MongoCursorLegacy >> execute [
	| limit reply numberReturned requestId |

	numberReturned := 0.
	limit := query limit.
	limit = 0
		ifTrue: [ limit := Float infinity ].
	limit < query chunkSize
		ifTrue: [ query chunkSize: limit ].

	reply := nil.
	[
		requestId := reply
			ifNotNil:[
				self
					fetchMoreCursorId: reply cursorId
					chunkSize: query chunkSize
					collection: query collection ]
			ifNil: [
				self cursorQuery: query ].
			
		reply := (ReplyOperation stream: root stream) read.
		reply responseTo = requestId
			ifFalse: [ ^ MongoWireProtocolError signal: 'Unexpected responseTo in response' ].
		reply do: [:each |
			numberReturned < limit ifTrue: [
				query doBlock value: each.
				numberReturned := numberReturned + 1 ] ].
		reply isFinished or: [ numberReturned >= limit ]
	]
	whileFalse
]

{ #category : #private }
MongoCursorLegacy >> fetchMoreCursorId: cursorId chunkSize: count collection: aCollection [
	| id |

	id := self root nextRequestID.
	(GetMoreOperation
		collection: aCollection qualifiedName
			id: id
			stream: self root stream
			cursorId: cursorId
			returnCount: count)
		write.

	^ id
]
