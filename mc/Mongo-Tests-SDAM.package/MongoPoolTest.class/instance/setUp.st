running
setUp
	pool := MongoPool url: 'localhost' asMongoUrl.
	root := pool next.

	database := root databaseNamed: 'test'.
	collection := database addCollection: 'testCollection'.
