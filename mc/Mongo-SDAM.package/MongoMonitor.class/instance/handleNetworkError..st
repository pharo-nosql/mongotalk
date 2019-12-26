accessing
handleNetworkError: aNetworkError
	roundtripTimeCalculator reset.
	self latestServerDescription:
		(MongoErrorServerDescription
			urlString: urlString
			errorDescription: aNetworkError description)