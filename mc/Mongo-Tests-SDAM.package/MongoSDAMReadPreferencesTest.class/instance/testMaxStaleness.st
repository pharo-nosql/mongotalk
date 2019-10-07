tests
testMaxStaleness

	self timeLimit: self defaultTimeLimit + self maxStaleness.

	client readPreference: (MongoReadPreference newPrimaryPreferred maxStaleness: self maxStaleness; yourself).

	self prepareScenarioWhereAllExceptCStopped.

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

	MongoReplicationTestResources continueAllServers.
	self waitMonitorsHeartbeatAndTimeout.
	
	"Ensure it reads again from A"
	self doReadOnClient.
