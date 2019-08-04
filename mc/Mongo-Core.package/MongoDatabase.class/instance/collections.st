operations
collections
	"Answer the collections in this database"

	^ self collectionNames collect: [ :each | self collectionAt: each ]