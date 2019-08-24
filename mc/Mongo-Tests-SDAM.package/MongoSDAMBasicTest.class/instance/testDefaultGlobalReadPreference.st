tests
testDefaultGlobalReadPreference

	client := MongoSDAMClient withUrls: {
		MongoReplicationTestResources mongoUrlA }.
		
	self assert: client readPreference type equals: MongoReadPreference newPrimary type.