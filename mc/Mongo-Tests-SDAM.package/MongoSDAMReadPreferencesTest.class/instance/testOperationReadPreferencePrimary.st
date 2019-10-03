tests
testOperationReadPreferencePrimary

	"Set another read preference as global."
	client readPreference: MongoReadPreference newPrimaryPreferred.

	self startClientAndWait.

	"Write and read on primary (A)"
	self writeAndReadFromA.

	"Then stop all but C, and finally wait until monitors realize."
	self stopAllExceptCAndWait.
	
	"It can't do a read command from the secondary (B)"
	self
		should: [ self doReadOnClient: MongoReadPreference newPrimary ]
		raise: MongoSDAMServerSelectionTimeout.
