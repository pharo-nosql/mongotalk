running
ensureTestingScenario
	self continueAllServers.

	MongoReplicationTestResources
		waitMongoAt: MongoReplicationTestResources mongoUrlA
		satisfies: [ :mongo |
			| isMasterResponse |
			isMasterResponse := mongo isMaster.
			(isMasterResponse hasPrimary
				and: [ isMasterResponse primaryUrlString = mongo urlString ])
				and: [ (mongo databaseNames includes: self databaseNameForTesting) not 
					or: [ (mongo databaseNamed: self databaseNameForTesting) drop. true ] ] ]
		upTo: 25 seconds
		onCompletion: [ Transcript << 'DONE' ]
		onTimeout: [ Transcript << 'TIMEOUT' ].

