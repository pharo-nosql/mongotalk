initialization
initializeIsMaster: aMongoIsmaster roundtripDurationAverage: aDuration
	self initializeUrlString: aMongoIsmaster urlString.
	isMaster := aMongoIsmaster.
	roundtripDurationAverage := aDuration.