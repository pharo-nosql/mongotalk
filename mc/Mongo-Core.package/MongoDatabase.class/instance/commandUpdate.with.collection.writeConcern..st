operations
commandUpdate: origDictionary with: newDictionary collection: collectionName writeConcern: aConcern
	"Update using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/update/"

	| dict |
	dict := {
		'update'->collectionName.
		'updates'->{{
			'q'->origDictionary.
			'u'->newDictionary.
			} as: OrderedDictionary}.
		} as: OrderedDictionary.
	aConcern ifNotNil: [
		dict at: 'writeConcern' put: aConcern concernForCommand].
	^self command: dict.