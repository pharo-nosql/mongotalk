tests
testAuth
	root authMechanism: (SCRAMSHA1AuthMechanism root: root).
	"root authMechanism: (MONGODBCRAuthMechanism root: root)."
	self assert: (root authenticateUsername: 'pharounittest' password: 'test' database: root admin).
	self assert: (root authenticateUsername: 'pharounittest' password: 'invalid' database: root admin) not