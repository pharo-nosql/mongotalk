private
newClient
	client := MongoClient withUrls: MongoReplicationTestResources allMongoUrls.
	client settings
		connectTimeout: 5 seconds;
		readPreference: self readPreference.
	^ client