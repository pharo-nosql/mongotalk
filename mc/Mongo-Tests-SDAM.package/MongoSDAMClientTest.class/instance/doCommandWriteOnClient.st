running
doCommandWriteOnClient
	client mongoDo: [ :mongo |
		| database collection |
		database := mongo databaseNamed: self databaseNameForTesting.
		collection := database addCollection: self collectionNameForTesting.
		collection 
			commandInsert: (Dictionary new at: 'key1' put: 'value1'; yourself) 
			writeConcern: self writeConcernForTesting.
		]