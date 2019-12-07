tests
testInsertDuplicateError
	| value wasInsertionError |
	value := { '_id' -> 1 } asDictionary.
	collection commandInsert: value writeConcern: nil.

	self
		should: [ 
			collection
				commandInsert: value
				writeConcern: nil ]
		raise: MongoCommandError
		withExceptionDo: [ :error |
			wasInsertionError := error isInsertionError ].

	self assert: wasInsertionError.