tests
testOperationReadPreferencePrimaryPreferred

	"Ensure the global setting is not the one being tested."
	client settings readPreference: MongoReadPreference newPrimary.

	self prepareScenarioWhereAllExceptCStopped.
	
	"It reads from secondary (C)"
	self doReadWith: MongoReadPreference newPrimaryPreferred.