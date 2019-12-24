tests
setUp
	super setUp.

	database := mongo databaseNamed: MongoReplicationTestResources databaseName.
	collection := database getCollection: 'testCollection'.
