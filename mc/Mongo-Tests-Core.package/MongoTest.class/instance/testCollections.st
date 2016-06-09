tests
testCollections
	| new |
	new := database addCollection: 'collection'.
	[self assert: (database collections contains: [:each | each name = 'collection'])]
		ensure: [new drop]