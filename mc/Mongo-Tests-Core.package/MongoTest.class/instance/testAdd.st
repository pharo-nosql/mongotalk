tests
testAdd
	| data |
	data := Dictionary new at: 'key' put: 'value'; yourself.
	collection add: data.
	self assert: (collection includes: data)