running
doWriteOnClient
	client mongoDo: [ :mongo |
		| database collection |
		database := mongo databaseNamed: self databaseNameForTesting.
		collection := database addCollection: self collectionNameForTesting.
		^ self doWriteOnCollection: collection ].
	self fail.