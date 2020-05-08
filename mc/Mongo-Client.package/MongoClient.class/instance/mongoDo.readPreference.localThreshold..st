API
mongoDo: aBlockClosure readPreference: aReadPreference localThreshold: localThresholdDuration
	"Evaluate aBlockClosure with a Mongo instance selected using aReadPreference and localThresholdDuration instead of the default parameters."

	^ self
		mongoDo: aBlockClosure
		serverSelection: (self newServerSelection
			readPreference: aReadPreference;
			localThreshold: localThresholdDuration;
			yourself)
