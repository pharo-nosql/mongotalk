accessing
handleHeatbeatSuccess: isMasterResponse for: roundtripDuration
	client announceIfNeeded: [
		MongoHeartbeatSucceeded 
			urlString: urlString
			roundtripTimeDuraton: roundtripDuration
			isMaster: isMasterResponse ].

	roundtripTimeCalculator add: roundtripDuration asMilliSeconds.

	self latestServerDescription:
		(MongoServerDescription
			urlString: urlString
			isMaster: isMasterResponse
			roundtripTime: self roundtripDurationAverage)