private-communicating
getMore: idInteger collection: aString chunkSize: countInteger
	| id |
	id := self nextRequestID.
	(GetMoreOperation
		collection: aString 
		id: id 
		stream: stream 
		cursorId: idInteger 
		returnCount: countInteger)
			write.
	^id