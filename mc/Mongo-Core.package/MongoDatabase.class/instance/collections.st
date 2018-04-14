operations
collections
	"Answer the collections in this database"

	| collectionNames |
	collectionNames := root majorVersion < 3
		ifTrue: [ self mongo2CollectionNames ]
		ifFalse: [ self mongo3CollectionNames ].
	^ collectionNames
		collect: [:each | MongoCollection database: self name: each ]