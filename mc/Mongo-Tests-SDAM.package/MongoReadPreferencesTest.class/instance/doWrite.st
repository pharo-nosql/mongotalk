running
doWrite
	client primaryMongoDo: [ :mongo |
		| database collection |
		database := mongo databaseNamed: MongoReplicationTestResources databaseName.
		collection := database addCollection: self collectionNameForTesting.
		^ self doWriteOnCollection: collection ].

	self fail.