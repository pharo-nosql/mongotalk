API
primaryMongoDo: aBlockClosure
	"Evaluate aBlockClosure with a 'primary' Mongo instance."

	^ self
		mongoDo: aBlockClosure
		readPreference: PRIMARY_READ_PREFERENCE
