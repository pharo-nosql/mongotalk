operations
commandFind: filterDictionary limit: aLimit collection: collectionName readConcern: aConcern
	"Answer a MongoCommandCursor that will perform a find using Mongo command.
	
	All parameters are optional (nil), except collectionName.
	
	See more on https://docs.mongodb.com/v4.0/reference/command/find/"

	| dict |
	dict := OrderedDictionary new.
	dict at: 'find' put: collectionName.
	filterDictionary ifNotNil: [
		dict at: 'filter' put: filterDictionary ].
	aLimit ifNotNil: [
		dict at: 'limit' put: aLimit ].
	aConcern ifNotNil: [
		dict at: 'readConcern' put: aConcern concernForCommand ].

	^ MongoCommandCursor database: self dictionary: dict