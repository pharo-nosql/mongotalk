API
mongoDo: aBlockClosure readPreference: aReadPreference localThreshold: localThresholdDuration
	"Evaluate a block closure with a Mongo instance, which selects according to the 'Server Selection Algorithm'. 
	Source: https://docs.mongodb.com/manual/core/read-preference-mechanics/"

	| selectedMonitor |
	selectedMonitor := serverSelectionStrategy
		detectMonitorFor: aReadPreference
		localThreshold: localThresholdDuration.

	^ [[ selectedMonitor pool mongoDo: aBlockClosure ]
			on: MongoCommandError, MongoQueryError
				do: [ :error | self handleMongoQueryOrCommandError: error on: selectedMonitor ]]
			on: NetworkError
				do: [ :error | self handleNetworkError: error on: selectedMonitor ]