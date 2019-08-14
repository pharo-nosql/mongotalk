private
handleMongoQueryOrCommandError: aMongoQueryOrCommandError
	"Handles an error happened during the execution of a query or command."

	aMongoQueryOrCommandError isNotMasterAndSlaveOkIsFalse ifTrue: [
		
		self flag: #todo. "It's not unreachable!"
		
		self refreshTopologyWith: (MongoSDAMUnreachableServerDescription urlString: aMongoQueryOrCommandError signaler urlString) ]