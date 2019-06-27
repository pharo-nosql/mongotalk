operations
getCollection: aString
	^ [ self addCollection: aString capped: false size: nil max: nil ]
		on: MongoCollectionAlreadyExists 
		do: [ :err | self collectionAt: aString ]