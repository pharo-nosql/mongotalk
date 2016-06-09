tests
testGetNoneExistingCollection
	| new |
	new := database getCollection: 'collection'.
	[self assert: (database collections contains: [:each | each name = 'collection'])]
		ensure: [new drop]