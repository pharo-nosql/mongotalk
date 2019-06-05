instance creation
isMaster: aMongoIsmaster roundtripTime: aDuration
	^ self basicNew
		initializeIsMaster: aMongoIsmaster roundtripTime: aDuration;
		yourself