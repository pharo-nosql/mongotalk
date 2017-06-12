accessing
authMechanism
	^ authMechanism ifNil: [ authMechanism := MONGODBCRAuthMechanism root: self ]