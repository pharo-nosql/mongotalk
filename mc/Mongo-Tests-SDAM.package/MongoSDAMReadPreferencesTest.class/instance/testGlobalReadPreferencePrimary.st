tests
testGlobalReadPreferencePrimary

	self timeLimit: (30 seconds + client serverSelectionTimeout).

	"Set global readPreference"
	client readPreference: MongoReadPreference newPrimary.

	self prepareScenarioWhereAllExceptCStopped.

	self
		should: [ self doReadOnClient ]
		raise: MongoSDAMServerSelectionTimeout.
