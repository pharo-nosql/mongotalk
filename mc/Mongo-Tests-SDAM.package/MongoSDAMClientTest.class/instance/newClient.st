running
newClient
	^ (MongoSDAMClient withUrls: self urlsToTest)
			connectTimeout: 5 seconds;
			socketTimeout: 5 seconds;
			heartbeatFrequency: 3 seconds;
			yourself