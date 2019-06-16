running
setUp
	pool := MongoPool url: 'localhost' asMongoUrl.
	root := pool availableMongo.

	database := root databaseNamed: 'test'.
	collection := database addCollection: 'testCollection'.
