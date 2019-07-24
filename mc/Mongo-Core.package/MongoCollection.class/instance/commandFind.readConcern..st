operations
commandFind: filterDictionary readConcern: aConcern
	"Find (select) using Mongo command. Answer the output of the command.
	See more on https://docs.mongodb.com/manual/reference/command/find/"

	^ MongoQueryBatch
		newFromFindResponse:
			(database
				commandFind: filterDictionary
				collection: name
				readConcern: aConcern)