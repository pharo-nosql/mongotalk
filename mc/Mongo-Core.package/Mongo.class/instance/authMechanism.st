accessing
authMechanism
	^ authMechanism ifNil: [ authMechanism := self class defaultAuthMechanismClass root: self ]