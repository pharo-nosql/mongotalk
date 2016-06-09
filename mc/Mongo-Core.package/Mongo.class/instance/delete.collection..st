private-communicating
delete: aDictionary collection: aString
	(DeleteOperation
		collection: aString 
		id: self nextRequestID 
		stream: stream 
		query: aDictionary)
			write