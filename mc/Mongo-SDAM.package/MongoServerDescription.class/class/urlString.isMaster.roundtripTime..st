instance creation
urlString: urlString isMaster: aMongoIsMaster roundtripTime: aDuration
	^ self basicNew
		initializeUrlString: urlString
			isMaster: aMongoIsMaster
			roundtripDurationAverage: aDuration;
		yourself