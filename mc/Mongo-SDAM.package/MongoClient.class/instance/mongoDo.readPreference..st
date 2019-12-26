API
mongoDo: aBlockClosure readPreference: aReadPreference
	"Evaluate aBlockClosure with a Mongo instance selected according to the SDAM specification.
	Use aReadPreference instead of the default parameter."

	^ self
		mongoDo: aBlockClosure
		serverSelection: (self newServerSelection
			readPreference: aReadPreference;
			yourself)
