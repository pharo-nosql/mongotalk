operations
commandFind: filterDictionary limit: aLimit readConcern: aConcern
	"Find (select) using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/find/"

	^ database
		commandFind: filterDictionary
		limit: aLimit
		collection: name
		readConcern: aConcern