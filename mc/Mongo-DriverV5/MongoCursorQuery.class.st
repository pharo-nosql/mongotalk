"
A command that performs a query in mongo (the equivallent of `find` in mongo). 
"
Class {
	#name : #MongoCursorQuery,
	#superclass : #MongoCursor,
	#category : #'Mongo-DriverV5-Base'
}

{ #category : #private }
MongoCursorQuery >> driver [

	^ root driver
]

{ #category : #executing }
MongoCursorQuery >> execute [
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

		reply := OpMsgReply fromStream: root stream.
		reply responseTo = requestId
			ifFalse: [ ^ MongoWireProtocolError signal: 'Unexpected responseTo in response' ].
		reply isOk
			ifFalse: [ ^ MongoCommandError signalFor: reply documents first ].

		reply batchDo: [:each |
			numberReturned < limit ifTrue: [
				query doBlock value: each.
				numberReturned := numberReturned + 1 ] ].
		reply isFinished or: [ numberReturned >= limit ]
	]
	whileFalse
]

{ #category : #private }
MongoCursorQuery >> fetchMoreCursorId: cursorId chunkSize: count collection: aMongoCollection [

	^ self cursorQuery: (self driver
		newQueryCommandWith: [ :spec | spec
			at: 'getMore' put: cursorId;
			at: 'collection' put: aMongoCollection name;
			at: 'batchSize' put: count ]
		database: aMongoCollection database
		flags: 0)
]
