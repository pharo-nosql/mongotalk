tests
testRemove
	| data |
	data := Dictionary new at: 'key' put: 'value'; yourself.
	collection add: data.
	self assert: collection size = 1.
	collection remove: data.
	self assert: collection isEmpty