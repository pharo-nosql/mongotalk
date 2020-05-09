API
mongoDo: aBlockClosure readPreference: aReadPreference
	"Evaluate aBlockClosure with a Mongo instance selected using aReadPreference instead of the default parameter."

	^ self
		mongoDo: aBlockClosure
		serverSelection: (self newServerSelection
			readPreference: aReadPreference;
			yourself)
