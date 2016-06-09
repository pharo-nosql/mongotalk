private-communicating
insert: aCollection collection: aString
	(InsertOperation
		collection: aString
		id: self nextRequestID
		stream: stream 
		objects: aCollection)
			write