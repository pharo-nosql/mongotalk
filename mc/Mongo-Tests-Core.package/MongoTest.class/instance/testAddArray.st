tests
testAddArray
	| data |
	data := Dictionary new at: 'key' put: #(3 1 2 44 5 432); yourself.
	collection add: data.
	self assert: (collection includes: data)