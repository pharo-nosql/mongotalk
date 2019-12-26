tests
testGlobalReadPreferencePrimaryPreferred

	"Set global readPreference"
	client readPreference: MongoReadPreference newPrimaryPreferred.

	self prepareScenarioWhereAllExceptCStopped.

	"It will read from C"
	client mongoDo: [ :mongo |
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlC.
		self doReadOnMongo: mongo ].