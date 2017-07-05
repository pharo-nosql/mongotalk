operations
commandUpdate: origDictionary with: newDictionary collection: collectionName 
	"Update using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/update/"

	^ self command: (OrderedIdentityDictionary new
		at: #update put: collectionName;
		at: #updates put: {{
			'q'->origDictionary.
			'u'->newDictionary.
			} asDictionary};
		yourself)