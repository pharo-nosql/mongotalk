running
doCommandReadOnClient
	client mongoDo: [ :mongo |
		| database collection |
		database := mongo databaseNamed: self databaseNameForTesting.
		collection := database collectionAt: self collectionNameForTesting.
		^ (collection
				commandFind: (Dictionary new at: 'key1' put: 'value1'; yourself)
				readConcern: nil) documents ]