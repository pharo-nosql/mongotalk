accessing
addServerAt: urlString
	serversByUrlString at: urlString put: (MongoSDAMUnknownServerDescription urlString: urlString)