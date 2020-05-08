API
mongoDo: aBlockClosure
	"Evaluate aBlockClosure with a Mongo instance selected according to the SDAM specification.
	Use the default parameters."

	^ self
		mongoDo: aBlockClosure
		serverSelection: self newServerSelection