initialization
initializeUrlString: aUrlString isMaster: aMongoIsMaster roundtripDurationAverage: aDuration
	self initializeUrlString: aUrlString.
	isMaster := aMongoIsMaster.
	roundtripDurationAverage := aDuration