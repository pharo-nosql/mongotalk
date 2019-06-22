operations
commandInsert: newDictionary collection: collectionName writeConcern: aConcern
	"Insert using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/insert/"

	| dict |
	dict := {
		'insert'->collectionName.
		'documents'->{newDictionary}.
		} as: OrderedDictionary.
	aConcern ifNotNil: [
		dict at: 'writeConcern' put: aConcern concernForCommand].
	^self commandAndVerify: dict.