accessing
handleSuccessfulIsMaster: isMasterResponse for: roundtripDuration
	roundtripTimeCalculator add: roundtripDuration asMilliSeconds.
	self latestServerDescription: (MongoSDAMServerDescription
		urlString: urlString
		isMaster: isMasterResponse
		roundtripTime: self roundtripDurationAverage)