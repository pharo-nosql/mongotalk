running
ensureTestingScenario
	self continueAllServers.

	Transcript << '=> Ensure C is secondary and passive: '.
	MongoReplicationTestResources
		waitMongoAt: MongoReplicationTestResources mongoUrlC
		satisfies: [ :mongo | mongo isMaster isSecondary and: [ mongo isMaster isPassive ]  ]
		upTo: 15 seconds
		onCompletion: [ Transcript << 'DONE' ]
		onTimeout: [ Transcript << 'TIMEOUT' ].

	Transcript << ' Ensure B is secondary: '.
	MongoReplicationTestResources
		waitMongoAt: MongoReplicationTestResources mongoUrlB
		satisfies: [ :mongo | mongo isMaster isSecondary ]
		upTo: 15 seconds
		onCompletion: [ Transcript << 'DONE' ]
		onTimeout: [ Transcript << 'TIMEOUT' ].

	Transcript << ' Ensure A is primary: '.
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

