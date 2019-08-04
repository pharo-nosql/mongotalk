running
setUp
	root := Mongo default.
	root open.
	database := root databaseNamed: 'test'.
	collection := database getCollection: 'testCollection'.
