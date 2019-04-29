operations
collectionNames
	"Answer the names of the collections in this database (for MongoDB >= 3.0).

	See more at https://docs.mongodb.com/manual/reference/command/listCollections/"

	| reply |
	reply := self command: {(#listCollections -> 1)} asDictionary.
	^ ((reply at: 'cursor') at: 'firstBatch') collect: [ :each | each at: 'name' ]