tests
testCollectionEnsureAdded
	collection := database collectionAt: 'collection'.
	self deny: (database collectionNames includes: 'collection').
	collection ensureAdded.
	self assert: (database collectionNames includes: 'collection').
	collection ensureAdded.
	self assert: (database collectionNames includes: 'collection').
