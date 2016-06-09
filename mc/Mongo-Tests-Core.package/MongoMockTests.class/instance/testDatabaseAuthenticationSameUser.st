tests
testDatabaseAuthenticationSameUser
	| database1 database2 |
	database1 := mongo databaseNamed: 'foo'.
	database1 username: 'foo' password: 'bar'.
	database2 := mongo databaseNamed: 'foo'.
	database2 username: 'foo' password: 'bar'.
	self assert: mongo authCalls = 1.
	self assert: mongo authCache keys size = 1
	