tests
setUp
	super setUp.
	database := mongo databaseNamed: 'test'.
	collection := database addCollection: 'testCollection'.
