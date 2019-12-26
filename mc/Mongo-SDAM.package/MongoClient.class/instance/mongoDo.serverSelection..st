API
mongoDo: aBlockClosure serverSelection: aMongoServerSelection
	"Evaluate aBlockClosure with a Mongo instance selected according to the SDAM specification.
	Use the parameters setted in aMongoServerSelection."

	| selectedMonitor |
	selectedMonitor := aMongoServerSelection execute; selectedMonitor.

	^ [ [ selectedMonitor pool mongoDo: aBlockClosure ]
		on: MongoCommandError, MongoQueryError do: [ :error |
			self handleMongoQueryOrCommandError: error on: selectedMonitor ] ]
		on: NetworkError do: [ :error |
			self handleNetworkError: error on: selectedMonitor ]