private
handleHeatbeatError: anError
	"React to a heatbeat failure."

	client announceIfNeeded: [
		MongoHeartbeatFailed
			urlString: urlString
			errorDescription: anError description ].

	self handleConnectionError: anError.