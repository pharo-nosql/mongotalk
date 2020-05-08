API
mongoDo: aBlockClosure serverSelection: aMongoServerSelection
	"Evaluate aBlockClosure with a Mongo instance selected using the parameters setted in aMongoServerSelection."

	| selectedMonitor |
	selectedMonitor := aMongoServerSelection execute; selectedMonitor.

	^ [ [ selectedMonitor pool mongoDo: aBlockClosure ]
		on: MongoCommandError, MongoQueryError do: [ :error |
			self handleMongoQueryOrCommandError: error on: selectedMonitor ] ]
		on: NetworkError, MongoWireProtocolError do: [ :error |
			self handleConnectionError: error on: selectedMonitor ]