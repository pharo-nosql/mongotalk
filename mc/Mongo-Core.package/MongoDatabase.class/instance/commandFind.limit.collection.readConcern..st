operations
commandFind: filterDictionary limit: aLimit collection: collectionName readConcern: aConcern

	| dict |
	dict := {
		'find' -> collectionName.
		'filter' -> filterDictionary.
		'limit' -> aLimit.
		} as: OrderedDictionary.

	aConcern ifNotNil: [
		dict at: 'readConcern' put: aConcern concernForCommand ].

	^ MongoCommandCursor database: self dictionary: dict