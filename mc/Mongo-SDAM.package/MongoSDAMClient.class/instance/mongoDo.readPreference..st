accessing
mongoDo: aBlockClosure readPreference: aReadPreference
	"Evaluate a block closure with a Mongo instance, which selects according to the 'Server Selection Algorithm'. 
	Source: https://docs.mongodb.com/manual/core/read-preference-mechanics/"

	| selectedPool |
	selectedPool := self detectPoolWithTimeoutFor: aReadPreference.

	^ [[ selectedPool mongoDo: aBlockClosure ]
			on: MongoCommandError
			do: [ self notYetImplemented ]]
			on: MongoQueryError
				do: [ :error |
					self handleMongoQueryError: error.
					error signal ]