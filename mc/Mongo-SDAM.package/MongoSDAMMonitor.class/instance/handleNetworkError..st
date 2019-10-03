accessing
handleNetworkError: aNetworkError
	roundtripTimeCalculator reset.
	self latestServerDescription:
		(MongoSDAMErrorServerDescription
			urlString: urlString
			errorDescription: aNetworkError description)