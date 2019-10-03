running
newClient
	^ (MongoSDAMClient
			withUrls: MongoReplicationTestResources allMongoUrls)
			connectTimeout: 5 seconds;
			socketTimeout: 5 seconds;
			heartbeatFrequency: 3 seconds;
			yourself