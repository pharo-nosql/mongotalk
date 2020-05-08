API
mongoDo: aBlockClosure
	"Evaluate aBlockClosure with a Mongo instance selected using the default parameters."

	^ self
		mongoDo: aBlockClosure
		serverSelection: self newServerSelection