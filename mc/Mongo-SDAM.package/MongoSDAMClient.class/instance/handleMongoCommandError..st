private - error handling
handleMongoCommandError: aMongoCommandError 
	aMongoCommandError isNotMasterAndSlaveOkIsFalse ifTrue: [
		
		self flag: #todo. "It's not unreachable!"
		
		self refreshTopologyWith: (MongoSDAMUnreachableServerDescription urlString: aMongoCommandError signaler urlString) ]