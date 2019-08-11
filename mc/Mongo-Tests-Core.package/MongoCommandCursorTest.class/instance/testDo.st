tests
testDo
	| cursor collected |
	cursor := MongoCommandCursor database: database dictionary: self commandForTesting.
	
	collected := OrderedCollection new.
	cursor do: [ :each | collected add: each ].
	self assertExpectedDocuments: collected.
