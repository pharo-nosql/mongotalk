tests
testDatabases
	self assert: (root databases contains: [:each | each name = 'test'])