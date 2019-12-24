running
setUp
	pool := MongoPool
		url: 'localhost' asMongoUrl
		maxConnections: 5
		connectTimeout: 10 seconds
		socketTimeout: 5 seconds.
	
	root := pool next.

	database := root databaseNamed: 'test'.
	collection := database addCollection: 'testCollection'.
