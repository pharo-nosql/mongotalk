running
setUp
	root := Mongo default.
	database := root databaseNamed: 'test'.
	root open