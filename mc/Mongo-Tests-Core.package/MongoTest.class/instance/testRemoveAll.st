tests
testRemoveAll
	| data |
	data := Array 
		with: (Dictionary new at: 'key' put: 'value'; yourself) 
		with: (Dictionary new at: 'key2' put: 'value2'; yourself).
	collection addAll: data.
	self assert: collection size = 2.
	collection removeAll: data.
	self assert: collection isEmpty