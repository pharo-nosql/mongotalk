tests
testOperationReadPreferencePrimaryPreferred

	"Ensure the global setting is not the one being tested."
	client readPreference: MongoReadPreference newPrimary.

	self startClientAndWait.

	"Write and read on primary (A)"
	self writeAndReadFromA.

	"Then stop all but C, and finally wait until monitors realize."
	self stopAllExceptCAndWait.
	
	"It reads from secondary (C)"
	self doReadOnClient: MongoReadPreference newPrimaryPreferred.