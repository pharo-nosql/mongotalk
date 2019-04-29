tests
testDatabaseHasCollectionNamed
	self assert: (database hasCollectionNamed: 'testCollection').
	self deny: (database hasCollectionNamed: 'testCollection42')