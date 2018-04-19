operations
commandDelete: origDictionary limit: aLimit collection: collectionName writeConcern: aConcern
	"Delete using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/delete/"

	| dict |
	dict := {
		'delete'->collectionName.
		'deletes'->{{
			'q'->origDictionary.
			'limit'->aLimit.
			} asDictionary}.
		} asDictionary.
	aConcern ifNotNil: [
		dict at: 'writeConcern' put: aConcern concernForCommand].
	^self command: dict.