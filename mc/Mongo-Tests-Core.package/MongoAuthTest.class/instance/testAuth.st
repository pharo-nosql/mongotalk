tests
testAuth
	"root authMechanism: (SCRAMSHA1AuthMechanism root: root)."

	self assert: (root authenticateUsername: 'pharounittest' password: 'test' database: database).
	self assert: (root authenticateUsername: 'pharounittest' password: 'invalid' database: database) not