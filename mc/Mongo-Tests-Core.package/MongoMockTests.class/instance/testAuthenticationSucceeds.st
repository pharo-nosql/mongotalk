tests
testAuthenticationSucceeds
	self assert: (mongo authenticateUsername: 'foo' password: 'bar' database: 'baz')