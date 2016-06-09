tests
testIsEmpty
	| data |
	data := Dictionary new at: 'key' put: 'value'; yourself.
	self assert: collection isEmpty.
	collection add: data.
	self deny: collection isEmpty