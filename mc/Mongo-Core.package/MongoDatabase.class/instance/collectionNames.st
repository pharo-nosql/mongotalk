operations
collectionNames
	"Answer the names of the collections in this database.

	See more at https://docs.mongodb.com/manual/reference/command/listCollections/"

	| dictionary |
	dictionary := OrderedIdentityDictionary new
		at: #listCollections put: 1;
		at: #nameOnly put: true;
		yourself.

	^ (MongoCommandCursor
		database: self
		dictionary: dictionary)
		setFlagSlaveOk;
		collect: [ :each | each at: 'name' ].