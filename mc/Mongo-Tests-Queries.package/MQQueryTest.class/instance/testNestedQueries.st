tests
testNestedQueries
	| selected |
	collection add: (Dictionary new at: 'key1' put: 1; yourself).
	collection add: (Dictionary new at: 'key1' put: 2;  yourself).
	collection add: (Dictionary new at: 'key1' put: 3; at: 'key2' put: 2; yourself).
	collection add: (Dictionary new at: 'key1' put: 4;  yourself).
	collection add: (Dictionary new at: 'key1' put: 5;  yourself).
	collection add: (Dictionary new at: 'key1' put: 6;  yourself).
	
	selected := collection select: [ :each | 
		(each key1 = 1) | (each key1 = 3) | (each key1 = 5)] .
	self assert: selected size equals: 3.
	
	selected := collection select: [ :each | 
		(each key1 = 1) | (each key1 = 3) & (each key2 = 2)] .
	self assert: selected size equals: 1