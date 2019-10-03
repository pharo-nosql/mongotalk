tests
testGlobalReadPreferencePrimary

	self timeLimit: (30 seconds + client serverSelectionTimeout).

	"Set global readPreference"
	client readPreference: MongoReadPreference newPrimary.

	self startClientAndWait.

	"Write and read on primary (A)"
	self writeAndReadFromA.
	
	"It can't do a read command from the only secondary (C)"
	self stopAllExceptCAndWait.
	self
		should: [ self doReadOnClient ]
		raise: MongoSDAMServerSelectionTimeout.
