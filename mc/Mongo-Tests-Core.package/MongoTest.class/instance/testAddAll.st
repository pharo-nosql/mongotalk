tests
testAddAll
	| data |
	data := Array 
		with: (Dictionary new at: 'key' put: 'value'; yourself) 
		with: (Dictionary new at: 'key2' put: 'value2'; yourself).
	collection addAll: data.
	self assert: (collection includes: data first).
	self assert: (collection includes: data last)