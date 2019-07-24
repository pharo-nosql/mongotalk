running
doQueryWriteOnClient
	client mongoDo: [ :mongo |
		| database collection |
		database := mongo databaseNamed: self databaseNameForTesting.
		collection := database addCollection: self collectionNameForTesting.
		collection add: (Dictionary new at: 'key1' put: 'value1'; yourself).
		]