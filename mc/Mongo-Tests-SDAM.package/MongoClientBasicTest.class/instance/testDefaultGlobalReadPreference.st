tests
testDefaultGlobalReadPreference
	client := MongoClient
		withUrls: {MongoReplicationTestResources mongoUrlA}.
	self
		assert: client settings readPreference class
		equals: MongoPrimaryReadPreference