tests
testDatabaseAuthenticationDifferentUser
	| database |
	database := mongo databaseNamed: 'foo'.
	database username: 'foo' password: 'bar'.
	database username: 'bar' password: 'foo'.
	self assert: mongo authCalls = 2.
	self assert: mongo authCache keys size = 1
	