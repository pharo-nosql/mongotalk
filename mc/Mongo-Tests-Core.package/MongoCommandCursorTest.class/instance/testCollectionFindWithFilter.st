tests
testCollectionFindWithFilter
	| commandCursor |
	commandCursor := collection
		commandFind: (Dictionary new at: 'index' put: 3; yourself)
		limit: nil
		readConcern: nil.

	self assert: commandCursor contents size equals: 1.
