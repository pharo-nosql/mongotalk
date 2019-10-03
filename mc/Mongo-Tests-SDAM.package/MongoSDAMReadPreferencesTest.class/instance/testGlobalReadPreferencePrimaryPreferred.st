tests
testGlobalReadPreferencePrimaryPreferred

	"Set global readPreference"
	client readPreference: MongoReadPreference newPrimaryPreferred.

	self startClientAndWait.

	"Write and read on primary (A)"
	self writeAndReadFromA.
	
	"It reads from secondary (C)"
	self stopAllExceptCAndWait.
	self doReadOnClient.
