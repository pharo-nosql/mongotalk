accessing
handleConnectionError: anError
	roundtripTimeCalculator reset.
	self latestServerDescription:
		(MongoErrorServerDescription
			urlString: urlString
			errorDescription: anError description)