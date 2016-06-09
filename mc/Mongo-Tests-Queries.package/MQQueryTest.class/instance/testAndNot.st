tests
testAndNot
	| selected block |
	collection add: (Dictionary new at: 'key1' put: 1; yourself).
	collection add: (Dictionary new at: 'key1' put: 2;  yourself).
	collection add: (Dictionary new at: 'key1' put: 3; at: 'key2' put: 2; yourself).
	collection add: (Dictionary new at: 'key1' put: 4;  yourself).
	collection add: (Dictionary new at: 'key1' put: 5;  yourself).
	collection add: (Dictionary new at: 'key1' put: 6;  yourself).
	
	block := [ :each | ((each key1 = 3) & (each key2 = 2) & (each key1 = 5)) not ].
	
	self assert: (collection select: block) size equals: 4