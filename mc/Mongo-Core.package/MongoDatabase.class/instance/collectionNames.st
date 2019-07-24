operations
collectionNames
	"Answer the names of the collections in this database.

	See more at https://docs.mongodb.com/manual/reference/command/listCollections/"

	^ ((self listCollections at: 'cursor') at: 'firstBatch')
			collect: [ :each | each at: 'name' ]