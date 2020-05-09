tests
testGlobalReadPreferencePrimaryPreferred

	"Set global readPreference"
	client settings readPreference: MongoReadPreference newPrimaryPreferred.

	self prepareScenarioWhereAllExceptCStopped.

	"It will read from C"
	client mongoDo: [ :mongo |
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlC.
		self doReadOnMongo: mongo ].