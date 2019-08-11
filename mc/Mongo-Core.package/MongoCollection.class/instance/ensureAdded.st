convenience
ensureAdded
	[ database addCollection: name ]
		on: MongoCollectionAlreadyExists
		do: [ :error | ]