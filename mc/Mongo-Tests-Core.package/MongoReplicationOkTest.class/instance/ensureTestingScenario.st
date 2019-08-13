instance creation
ensureTestingScenario
	MongoReplicationTestResources
		waitMongoAt: MongoReplicationTestResources mongoUrlA
		satisfies: [ :aMongo |
			| isMasterResponse |
			isMasterResponse := aMongo isMaster.
			isMasterResponse hasPrimary and: [
				isMasterResponse primaryUrlString = MongoReplicationTestResources mongoUrlA ] ]
		upTo: 25 seconds
		onCompletion: [ Transcript << 'READY' ]
		onTimeout: [ Transcript << 'TIMEOUT' ].

