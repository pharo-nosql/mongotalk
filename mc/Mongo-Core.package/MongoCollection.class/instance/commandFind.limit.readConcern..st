operations
commandFind: filterDictionary limit: aLimit readConcern: aMongoReadConcern
	"Answer a MongoCommandCursor that will perform a find using Mongo command.

	All parameters are optional (nil).

	See more on https://docs.mongodb.com/v4.0/reference/command/find/"

	^ database
		commandFind: filterDictionary
		limit: aLimit
		collection: name
		readConcern: aMongoReadConcern