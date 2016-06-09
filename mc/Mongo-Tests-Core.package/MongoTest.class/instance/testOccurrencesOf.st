tests
testOccurrencesOf
	| data |
	data := (Dictionary new)
				at: 'key1' put: 'value1';
				yourself.
	collection add: data.
	self assert: (collection occurrencesOf: data) equals: 1