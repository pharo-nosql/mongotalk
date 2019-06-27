private - error handling
handleMongoQueryError: aMongoQueryError 
	aMongoQueryError isNotMasterAndSlaveOkIsFalse ifTrue: [
		
		self flag: #todo. "It's not unreachable!"
		
		self refreshTopologyWith: (MongoSDAMUnreachableServerDescription urlString: aMongoQueryError signaler urlString) ]