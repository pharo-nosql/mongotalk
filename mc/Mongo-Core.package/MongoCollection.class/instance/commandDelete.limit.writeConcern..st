private-operations
commandDelete: origDictionary limit: aLimit writeConcern: aConcern
	"Update using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/delete/"

	^database commandDelete: origDictionary limit: aLimit collection: name writeConcern: aConcern