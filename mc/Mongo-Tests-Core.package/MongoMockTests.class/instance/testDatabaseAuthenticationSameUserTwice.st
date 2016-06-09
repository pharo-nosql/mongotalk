tests
testDatabaseAuthenticationSameUserTwice
	| database |
	database := mongo databaseNamed: 'foo'.
	database username: 'foo' password: 'bar'.
	database username: 'foo' password: 'bar'.
	self assert: mongo authCalls = 1
	