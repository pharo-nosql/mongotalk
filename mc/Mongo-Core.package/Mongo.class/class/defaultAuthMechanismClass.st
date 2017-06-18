accessing
defaultAuthMechanismClass
	^ defaultAuthMechanismClass ifNil: [ MONGODBCRAuthMechanism ]