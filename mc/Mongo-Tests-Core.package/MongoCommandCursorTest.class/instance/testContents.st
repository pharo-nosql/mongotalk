tests
testContents
	| cursor |
	cursor := MongoCommandCursor database: database dictionary: self commandForTesting.
	
	self assertExpectedDocuments: cursor contents.
