tests
testMaxStaleness

	self timeLimit: self maxStaleness + 90 seconds.

	client readPreference: (MongoReadPreference newPrimaryPreferred maxStaleness: self maxStaleness; yourself).

	self startClientAndWait.

	"Write and read on primary (A)"
	self writeAndReadFromA.

	"It reads from secondary (C)"
	self stopAllExceptCAndWait.
	client mongoDo: [ :mongo |
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlC.
		self doReadOnMongo: mongo ].

	"Wait until staleness of C is too high."
	self maxStaleness wait.

	[ client mongoDo: [ :mongo |
		self fail: 'should not find a server because staleness is too high' ] ]
			on: MongoSDAMServerSelectionTimeout
			do: [:e | Transcript << 'expected timeout'; cr ].

	self continueAllServers.
	self waitMonitorsHeartbeatAndTimeout.
	
	"Ensure it reads again from A"
	self doReadOnClient.
