tests
testInsertTwoAndQuery
	| results |
	collection add: (Dictionary new at: 'key1' put: 'value1'; yourself).
	collection add: (Dictionary new at: 'key2' put: 'value2'; yourself).
	self assert: collection size = 2.
	results := collection query: [ :query | ].
	self assert: results size = 2