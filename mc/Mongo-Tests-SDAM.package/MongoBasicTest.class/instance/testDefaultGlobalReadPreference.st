tests
testDefaultGlobalReadPreference

	client := MongoClient withUrls: {
		MongoReplicationTestResources mongoUrlA }.
		
	self assert: client readPreference class equals: MongoPrimaryReadPreference.