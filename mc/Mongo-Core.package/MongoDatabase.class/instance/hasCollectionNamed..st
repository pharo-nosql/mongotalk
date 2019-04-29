testing
hasCollectionNamed: aString
	"Answers true if this database has a collection named aString"
	
	^ self collectionNames includes: aString