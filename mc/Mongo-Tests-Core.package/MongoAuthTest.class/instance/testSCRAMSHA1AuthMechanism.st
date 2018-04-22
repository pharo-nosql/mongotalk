tests
testSCRAMSHA1AuthMechanism
	"ToDo: this test requires manual configuration. 
	=> Run in command-line:
	mongo test --eval 'db.createUser({ ""user"": ""pharounittest"", ""pwd"": ""test"", roles: [] });'
	"
	root majorVersion < 3 ifTrue: [ self skip ]. "Implemented in 3.0"

	root authMechanism: (SCRAMSHA1AuthMechanism root: root).

	self assert: (root authenticateUsername: 'pharounittest' password: 'test' database: database).
	self assert: (root authenticateUsername: 'pharounittest' password: 'invalid' database: database) not