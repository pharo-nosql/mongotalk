tests
testReadRetryInC

	client readPreference: MongoReadPreference newPrimaryPreferred.

	self startClientAndWait.
	self writeAndReadFromA.
	self stopAllExceptC.
	
	"First time, it will use A since it was the primary up to now, but will error."
	client mongoDo: [ :mongo |
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlA.
		self
			should: [ self doReadOnMongo: mongo ]
			raise: ConnectionTimedOut ].

	self waitMonitorsHeartbeatAndTimeout.

	"After enough time passed, the client must know that B wasn't available.
	Then, the read on server C should succeed."
	client mongoDo: [ :mongo |
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlC.
		self doReadOnMongo: mongo ].

