tests
testNot
	| selected |
	collection add: (Dictionary new at: 'key1' put: 1; yourself).
	collection add: (Dictionary new at: 'key1' put: 2;  yourself).
	collection add: (Dictionary new at: 'key1' put: 3;  yourself).
	
	self flag: #todo. "error: not yet implemented?"
"	selected := collection select: [ :each | (each key1 > 1) not ].
	self assert: selected size equals: 1."
	
	selected := collection select: [ :each | (each key1 = 1) not ].
	self assert: selected size equals: 2.