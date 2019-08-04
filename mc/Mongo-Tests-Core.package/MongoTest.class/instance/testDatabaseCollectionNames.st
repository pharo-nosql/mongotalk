tests
testDatabaseCollectionNames
	| names |
	names := database collectionNames.
	self assert: (names includes: 'testCollection').
	self deny: (names includes: 'testCollection42').