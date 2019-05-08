initialization
initializeIsmaster: aMongoIsmaster roundtripTime: aDuration
	self initializeUrlString: aMongoIsmaster urlString.
	ismaster := aMongoIsmaster.
	roundtripTime := aDuration.