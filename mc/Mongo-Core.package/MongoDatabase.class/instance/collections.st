operations
collections
	"Answer the collections in this database"

	^ self collectionNames
		collect: [ :each | MongoCollection database: self name: each ]