tests
testDelete
	| results data |
	data := (Dictionary new)
				at: 'key' put: 'value';
				yourself.
	collection add: data.
	collection delete: data.
	results := collection query: [ :query | ].
	self assert: results isEmpty