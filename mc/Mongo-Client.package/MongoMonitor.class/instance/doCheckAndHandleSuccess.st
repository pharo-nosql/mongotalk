private
doCheckAndHandleSuccess

	| response roundtripDuration |
	client announceIfNeeded: [
		MongoHeartbeatStarted urlString: urlString ].

	roundtripDuration := [ response := mongo isMaster ] timeToRun.

	self handleHeatbeatSuccess: response for: roundtripDuration.