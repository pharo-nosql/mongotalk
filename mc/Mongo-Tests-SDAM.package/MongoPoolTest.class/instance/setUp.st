running
setUp
	| settings |
	settings :=
		MongoClientSettings new 
			maxConnections: 5;
			connectTimeout: 10 seconds;
			socketTimeout: 5 seconds;
			yourself.

	pool := MongoPool
		url: 'localhost' asMongoUrl
		settings: settings.
	
	root := pool next.

	database := root databaseNamed: 'test'.
	collection := database addCollection: 'testCollection'.
