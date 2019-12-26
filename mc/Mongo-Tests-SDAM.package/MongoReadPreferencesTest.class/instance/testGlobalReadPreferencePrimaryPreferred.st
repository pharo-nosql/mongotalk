tests
testGlobalReadPreferencePrimaryPreferred

	"Set global readPreference"
	client readPreference: MongoReadPreference newPrimaryPreferred.

	self prepareScenarioWhereAllExceptCStopped.

	self doReadOnClient.
