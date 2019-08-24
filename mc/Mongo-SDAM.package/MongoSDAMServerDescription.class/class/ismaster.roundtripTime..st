instance creation
isMaster: aMongoIsmaster roundtripTime: aDuration
	^ self basicNew
		initializeIsMaster: aMongoIsmaster roundtripDurationAverage: aDuration;
		yourself