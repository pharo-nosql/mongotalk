tests
testGetExistingCollection
	| existing |
	existing := database getCollection: 'testCollection'.
	self assert: existing name = 'testCollection'