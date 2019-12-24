tests
testDefaultGlobalReadPreference

	client := MongoSDAMClient withUrls: {
		MongoReplicationTestResources mongoUrlA }.
		
	self assert: client readPreference class equals: MongoPrimaryReadPreference.