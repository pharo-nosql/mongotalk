enumerating
firstBatch
	^ MongoQueryBatch newFromFirstBatchResponse: (database command: command flags: self flags)