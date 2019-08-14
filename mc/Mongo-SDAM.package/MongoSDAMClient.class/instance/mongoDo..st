API
mongoDo: aBlockClosure
	"Use the global read preference."
	
	^ self mongoDo: aBlockClosure readPreference: self readPreference