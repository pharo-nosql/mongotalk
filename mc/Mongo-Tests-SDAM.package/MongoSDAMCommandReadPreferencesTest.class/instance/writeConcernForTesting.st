running
writeConcernForTesting
	^ MongoWriteConcern new
		w: 1;
		j: false;
		wtimeout: 500;
		yourself