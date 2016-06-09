tests
testAnd
	| selected |
	collection add: (Dictionary new at: 'key1' put: 1; at: 'key2' put: 2; yourself).
	collection add: (Dictionary new at: 'key1' put: '1'; at: 'key2' put: 3; yourself).
	selected := collection select: [ :each | (each key1 = 1) & (each key2 = 2)] .
	self assert: selected size equals: 1