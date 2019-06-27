accessing
mongoDo: aBlockClosure
	"Use the global read preference."
	
	^ self mongoDo: aBlockClosure readPreference: readPreference