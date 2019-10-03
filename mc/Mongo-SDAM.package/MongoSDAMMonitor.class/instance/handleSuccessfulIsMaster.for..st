accessing
handleSuccessfulIsMaster: isMasterResponse for: roundtripDuration
	roundtripTimeCalculator add: roundtripDuration asMilliSeconds.
	self latestServerDescription: (MongoSDAMServerDescription
		isMaster: isMasterResponse
		roundtripTime: self roundtripDurationAverage)