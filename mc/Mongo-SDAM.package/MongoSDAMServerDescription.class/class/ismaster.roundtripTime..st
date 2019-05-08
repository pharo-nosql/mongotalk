instance creation
ismaster: aMongoIsmaster roundtripTime: aDuration
	^ self basicNew
		initializeIsmaster: aMongoIsmaster roundtripTime: aDuration;
		yourself