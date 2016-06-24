tests
testLastError
	| data |
	data := Dictionary new at: 'key' put: 'value'; yourself.
	collection add: data.
	
	self assert: database lastError ok