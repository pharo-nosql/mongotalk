tests
testGetNoneExistingCollection
	self deny: (database collectionNames includes: 'collection').
	database getCollection: 'collection'.
	self assert: (database collectionNames includes: 'collection').