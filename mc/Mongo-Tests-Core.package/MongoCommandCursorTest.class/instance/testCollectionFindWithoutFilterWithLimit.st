tests
testCollectionFindWithoutFilterWithLimit
	| commandCursor |
	commandCursor := collection
		commandFind: nil
		limit: 10
		readConcern: nil.

	self assert: commandCursor contents size equals: 10.
