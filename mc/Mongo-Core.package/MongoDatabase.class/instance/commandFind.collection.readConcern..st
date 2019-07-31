operations
commandFind: filterDictionary collection: collectionName readConcern: aConcern

	| dict |
	dict := {
		'find' -> collectionName.
		'filter' -> filterDictionary.
		} as: OrderedDictionary.

	aConcern ifNotNil: [
		dict at: 'readConcern' put: aConcern concernForCommand ].

	^ MongoCommandCursor database: self dictionary: dict