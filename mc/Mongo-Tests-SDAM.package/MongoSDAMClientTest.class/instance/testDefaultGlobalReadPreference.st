tests - read preference
testDefaultGlobalReadPreference

	client := MongoSDAMClient withUrls: {
		MongoReplicationTestResources mongoUrlA }.
		
	self assert: client readPreference equals: MongoReadPreference primary.