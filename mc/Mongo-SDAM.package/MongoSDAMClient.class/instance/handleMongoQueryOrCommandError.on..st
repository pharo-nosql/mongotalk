private
handleMongoQueryOrCommandError: aMongoQueryOrCommandError on: selectedMonitor
	"Handles an error happened during the execution of a query or command."

	aMongoQueryOrCommandError isNotMasterAndSlaveOkIsFalse ifTrue: [
		"Common case: the primary server changed to secondary"
		selectedMonitor
			latestServerDescription:
				(MongoSDAMErrorServerDescription
					urlString: aMongoQueryOrCommandError signaler urlString
					errorDescription: aMongoQueryOrCommandError description) ].

	aMongoQueryOrCommandError signal