tests
testAt
	| selected |
	collection add: (Dictionary new at: 'key1' put: 'value1'; yourself).
	collection add: (Dictionary new at: 'key2' put: 'value2'; yourself).
	
	selected := collection detect: [ :each | (each at: #key1) = 'value1'].
	self assert: (selected at: 'key1') equals: 'value1'.
	
	selected := collection detect: [ :each | (each at: 'key1') = 'value1'].
	self assert: (selected at: 'key1') equals: 'value1'