tests
testOperationReadPreferencePrimary

	"Set another read preference as global."
	client settings readPreference: MongoReadPreference newPrimaryPreferred.

	self prepareScenarioWhereAllExceptCStopped.
	
	"It can't do a read command from the secondary (B)"
	self
		should: [ self doReadWith: MongoReadPreference newPrimary ]
		raise: MongoServerSelectionTimeout.
