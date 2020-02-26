running
newClient
	client := MongoClient withUrls: self urlsToTest.
	client settings
		connectTimeout: 5 seconds;
		socketTimeout: 5 seconds;
		heartbeatFrequency: 3 seconds.
	^ client