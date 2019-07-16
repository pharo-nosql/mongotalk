running
ensureDeleteDatabaseForTesting
	MongoReplicationTestResources
		waitMongoAt: MongoReplicationTestResources mongoUrlA
		satisfies: [ :mongo |
			| isMasterResponse |
			Smalltalk garbageCollect.
			isMasterResponse := mongo isMaster.
			(isMasterResponse primaryUrlString = mongo urlString
				and: [ isMasterResponse primaryUrlString = mongo urlString ])
				and: [ mongo databaseNames logCr. (mongo databaseNames includes: self databaseNameForTesting) not 
					or: [ (mongo databaseNamed: self databaseNameForTesting) drop. true ] ].
			 ]
		upTo: 15 seconds
		onCompletion: [ Transcript << 'DONE' ]
		onTimeout: [ Transcript << 'TIMEOUT' ].

