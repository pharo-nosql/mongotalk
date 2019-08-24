API
mongoDo: aBlockClosure readPreference: aReadPreference localThreshold: localThresholdDuration
	"Evaluate a block closure with a Mongo instance, which selects according to the 'Server Selection Algorithm'. 
	Source: https://docs.mongodb.com/manual/core/read-preference-mechanics/"

	| selectedPool |
	selectedPool := self detectPoolWithTimeoutFor: aReadPreference localThreshold: localThresholdDuration.

	^ [ selectedPool mongoDo: aBlockClosure ]
			on: MongoCommandError, MongoQueryError
			do: [ :error |
				self handleMongoQueryOrCommandError: error.
				error signal ]
