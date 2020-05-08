tests
testCollectionFindWithReadConcernLocal
	| commandCursor |
	commandCursor := collection
		commandFind: nil
		limit: nil
		readConcern: MongoReadConcern local.

	self assert: commandCursor contents size equals: 1000.
