running
doReadOnMongo: mongo
	| database collection |
	database := mongo databaseNamed: self databaseNameForTesting.
	collection := database collectionAt: self collectionNameForTesting.
	^ self doReadOnCollection: collection