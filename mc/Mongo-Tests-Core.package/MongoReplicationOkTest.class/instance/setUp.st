tests
setUp
	super setUp.

	MongoReplicationTestResources waitTestingScenario.
	database := mongo databaseNamed: MongoReplicationTestResources databaseName.
	collection := database getCollection: 'testCollection'.
