tests
testCollectionFindWithFilter
	| commandCursor |
	commandCursor := collection
		commandFind: (Dictionary new at: 'index' put: 3; yourself)
		limit: 0
		readConcern: nil.

	self assert: commandCursor contents size equals: 1.
