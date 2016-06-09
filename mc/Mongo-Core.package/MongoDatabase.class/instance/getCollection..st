operations
getCollection: aString
	^ [ self addCollection: aString capped: false size: nil max: nil ]
		on: MongoCollectionAlreadyExists 
		do: [ :err | 
			MongoCollection database: self name: aString ]