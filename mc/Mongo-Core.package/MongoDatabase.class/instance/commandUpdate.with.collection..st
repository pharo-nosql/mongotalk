operations
commandUpdate: origDictionary with: newDictionary collection: collectionName 
	"Update using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/update/"

	^self command: {
		'update'->collectionName.
		'updates'->{{
			'q'->origDictionary.
			'u'->newDictionary.
			} asDictionary}.
		} asDictionary.