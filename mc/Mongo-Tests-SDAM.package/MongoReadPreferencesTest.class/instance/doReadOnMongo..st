running
doReadOnMongo: mongo
	| database collection |
	database := mongo databaseNamed: MongoReplicationTestResources databaseName.
	collection := database collectionAt: self collectionNameForTesting.
	^ self doReadOnCollection: collection