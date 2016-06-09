tests
testTwoDatabasesAuthenticationSameUser
	| database1 database2 |
	database1 := mongo databaseNamed: 'foo1'.
	database1 username: 'foo' password: 'bar'.
	database2 := mongo databaseNamed: 'foo2'.
	database2 username: 'foo' password: 'bar'.
	self assert: mongo authCalls = 2.
	self assert: mongo authCache keys size = 2
	