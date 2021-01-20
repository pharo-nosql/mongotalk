tests
testGlobalReadPreferencePrimary

	"Set global readPreference"
	client settings readPreference: MongoReadPreference newPrimary.

	self prepareScenarioWhereAllExceptCStopped.

	self
		should: [ self doRead ]
		raise: MongoServerSelectionTimeout.
