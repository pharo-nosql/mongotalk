operations
commandGetMore: cursorId batchSize: batchSizeOrNil timeout: aDurationOrNil
	"Get a batch of documents from this collection using a cursor id obtained via commandFind* (for example).

	Translates to:
	
	{
	   'getMore': <long>,
	   'collection': <string>,
	   'batchSize': <int>,
	   'maxTimeMS': <int>
	}

	See: https://docs.mongodb.com/manual/reference/command/getMore/#dbcmd.getMore"

	| dictionary |
	dictionary := OrderedIdentityDictionary new
		at: #getMore put: cursorId;
		at: #collection put: name;
		yourself.

	batchSizeOrNil ifNotNil: [
		dictionary at: #batchSize put: batchSizeOrNil ].

	aDurationOrNil ifNotNil: [
		dictionary at: #maxTimeMS put: aDurationOrNil asMilliSeconds ].

	^ MongoQueryBatch newFromGetMoreResponse: (database command: dictionary)