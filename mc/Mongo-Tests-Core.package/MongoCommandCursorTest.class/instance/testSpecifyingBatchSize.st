tests
testSpecifyingBatchSize
	| cursor |
	cursor := MongoCommandCursor database: database dictionary: self commandForTesting.
	cursor batchSizeOrNil: 10.
		
	self assertExpectedDocuments: cursor contents.
