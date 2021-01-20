running
addNewCollection
	(mongo databaseNamed: MongoReplicationTestResources databaseName)
		addCollection: 'testReplicaSetStepDown', UUID new asString36