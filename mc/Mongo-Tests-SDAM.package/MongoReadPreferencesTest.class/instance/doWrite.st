running
doWrite
	client
		mongoDo: [ :mongo |
			| database collection |
			database := mongo databaseNamed: MongoReplicationTestResources databaseName.
			collection := database addCollection: self collectionNameForTesting.
			^ self doWriteOnCollection: collection ]
		readPreference: MongoReadPreference newPrimary.

	self fail.