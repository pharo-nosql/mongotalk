initialization
initializeIsMaster: aMongoIsmaster roundtripTime: aDuration
	self initializeUrlString: aMongoIsmaster urlString.
	isMaster := aMongoIsmaster.
	roundtripTime := aDuration.