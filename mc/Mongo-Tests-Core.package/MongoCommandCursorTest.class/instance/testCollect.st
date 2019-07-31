tests
testCollect
	| cursor collected |
	cursor := MongoCommandCursor database: database dictionary: self commandForTesting.
	
	collected := cursor collect: [ :each | each ].
	self assertExpectedDocuments: collected.
