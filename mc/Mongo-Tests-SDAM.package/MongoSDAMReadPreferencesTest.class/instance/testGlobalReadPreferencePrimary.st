tests
testGlobalReadPreferencePrimary

	"Set global readPreference"
	client readPreference: MongoReadPreference newPrimary.

	self prepareScenarioWhereAllExceptCStopped.

	self
		should: [ self doReadOnClient ]
		raise: MongoSDAMServerSelectionTimeout.
