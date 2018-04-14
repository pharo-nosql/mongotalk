operations
mongo2CollectionNames
	"Answer the names of the collections in this database (for MongoDB < 3.0). 
	Before 3.0, it is possible to obtain this information via a query to <database>.system.namespaces.
	This has been deprecated since MongoDB 3.0, then such query returns an empty collection. See more at: https://docs.mongodb.com/manual/reference/system-collections/#%3Cdatabase%3E.system.namespaces"

	| query reply names real |
	query := MongoQuery new collection: (MongoMetaCollection name: 'system.namespaces').
	reply := self query: query.
	"Drop options on the floor for now"
	names := reply collect: [ :each | each at: 'name' ].
	real := names select: [ :each | (each occurrencesOf: $.) = 1 ].
	^real collect: [:each | each readStream upTo: $.; upToEnd ]