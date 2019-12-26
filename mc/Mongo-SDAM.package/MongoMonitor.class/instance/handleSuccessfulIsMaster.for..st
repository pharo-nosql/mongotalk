accessing
handleSuccessfulIsMaster: isMasterResponse for: roundtripDuration
	roundtripTimeCalculator add: roundtripDuration asMilliSeconds.
	self latestServerDescription: (MongoServerDescription
		urlString: urlString
		isMaster: isMasterResponse
		roundtripTime: self roundtripDurationAverage)