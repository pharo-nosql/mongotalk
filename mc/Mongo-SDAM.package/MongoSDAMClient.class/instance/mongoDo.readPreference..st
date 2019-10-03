API
mongoDo: aBlockClosure readPreference: aReadPreference
	"Evaluate a block closure with a Mongo instance, which selects according to the 'Server Selection Algorithm'. 
	Source: https://docs.mongodb.com/manual/core/read-preference-mechanics/"

	^ self
		mongoDo: aBlockClosure
		readPreference: aReadPreference
		localThreshold: self localThreshold