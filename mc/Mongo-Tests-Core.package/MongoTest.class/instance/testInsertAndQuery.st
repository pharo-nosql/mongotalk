tests
testInsertAndQuery
	| results |
	collection add: (Dictionary new at: 'key' put: 'value'; yourself).
	results := collection query: [ :query | ].
	self assert: results size equals: 1.
	self assert: (results first at: 'key') = 'value'