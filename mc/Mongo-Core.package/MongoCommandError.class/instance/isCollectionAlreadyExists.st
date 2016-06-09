testing
isCollectionAlreadyExists
	"Test if the cause of error when adding a collection was that the mongodb instance already has such collection."

	^ self 
		codeIfPresent: [ :code | code = 48 ] 
		ifAbsent: [ self errmsg = 'collection already exists' ]