running
setUp
	root := Mongo default.
	root open.
	database := root databaseNamed: 'testWholeDatabase'.
	collection := database addCollection: 'testCollection'