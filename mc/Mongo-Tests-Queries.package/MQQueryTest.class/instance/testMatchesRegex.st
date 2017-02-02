tests
testMatchesRegex
	collection add: (Dictionary new at: 'key1' put: 'hello';  yourself).
	
	self assert: (collection select: [ :each | each key1 matchesRegex: '^hel']) size equals: 1.
	self assert: (collection select: [ :each | each key1 matchesRegex: '^hel$']) size equals: 0. 