tests
testDefaultAuthMechanism

	self assert: Mongo defaultAuthMechanismClass equals: SCRAMSHA1AuthMechanism.
	self assert: root authMechanism class equals: SCRAMSHA1AuthMechanism.
