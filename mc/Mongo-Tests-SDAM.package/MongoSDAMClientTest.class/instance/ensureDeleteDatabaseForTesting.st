running
ensureDeleteDatabaseForTesting
	MongoReplicationTestResources
		waitMongoAt: MongoReplicationTestResources mongoUrlA
		satisfies: [ :mongo |
			| isMasterResponse |
			Smalltalk garbageCollect.
			isMasterResponse := mongo isMaster.
			(isMasterResponse hasPrimary
				and: [ isMasterResponse primaryUrlString = mongo urlString ])
				and: [ (mongo databaseNames includes: self databaseNameForTesting) not 
					or: [ (mongo databaseNamed: self databaseNameForTesting) drop. true ] ] ]
		upTo: 20 seconds
		onCompletion: [ Transcript << 'DONE' ]
		onTimeout: [ Transcript << 'TIMEOUT' ].

