private
newClient
	^ (MongoSDAMClient withUrls: MongoReplicationTestResources allMongoUrls)
		connectTimeout: 5 seconds;
		readPreference: self readPreference;
		yourself