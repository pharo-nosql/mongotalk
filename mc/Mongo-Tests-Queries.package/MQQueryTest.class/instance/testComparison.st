tests
testComparison
	| selected |
	collection add: (Dictionary new at: 'key1' put: 1; yourself).
	collection add: (Dictionary new at: 'key1' put: 2;  yourself).
	collection add: (Dictionary new at: 'key1' put: 3;  yourself).
	collection add: (Dictionary new at: 'key1' put: 4;  yourself).
	collection add: (Dictionary new at: 'key1' put: 5;  yourself).
	collection add: (Dictionary new at: 'key1' put: 6;  yourself).
	
	selected := collection select: [ :each | each key1 = 2 ] .
	self assert: selected size equals: 1.
	
	selected := collection select: [ :each | each key1 > 2 ] .
	self assert: selected size equals: 4.
	
	selected := collection select: [ :each | each key1 >= 2 ] .
	self assert: selected size equals: 5.
	
	selected := collection select: [ :each | each key1 < 2 ] .
	self assert: selected size equals: 1.
	
	selected := collection select: [ :each | each key1 <= 2 ] .
	self assert: selected size equals: 2.
	
	selected := collection select: [ :each | each key1 ~= 2 ] .
	self assert: selected size equals: 5.