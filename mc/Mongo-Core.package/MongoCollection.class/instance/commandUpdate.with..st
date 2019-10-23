operations
commandUpdate: origDictionary with: newDictionary
	"Update using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/update/"

	^database commandUpdate: origDictionary with: newDictionary collection: name