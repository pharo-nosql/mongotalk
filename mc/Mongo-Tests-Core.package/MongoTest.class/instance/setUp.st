running
setUp
	root := Mongo default.
	root open.
	database := root databaseNamed: 'test'.
	collection := database addCollection: 'testCollection'.
	
	root admin
		command:
			(OrderedIdentityDictionary new
				add: #createUser -> 'pharounittest';
				add: #pwd -> 'test';
				add: #roles -> {};
				yourself).