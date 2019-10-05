tests
testOperationReadPreferencePrimary

	"Set another read preference as global."
	client readPreference: MongoReadPreference newPrimaryPreferred.

	self prepareScenarioWhereAllExceptCStopped.
	
	"It can't do a read command from the secondary (B)"
	self
		should: [ self doReadOnClient: MongoReadPreference newPrimary ]
		raise: MongoSDAMServerSelectionTimeout.
