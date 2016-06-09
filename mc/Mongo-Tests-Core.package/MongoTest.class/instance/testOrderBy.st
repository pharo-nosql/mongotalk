tests
testOrderBy
	| results query |
	collection add: (Dictionary new at: 'key' put: 'b'; yourself).
	collection add: (Dictionary new at: 'key' put: 'a'; yourself).
	collection add: (Dictionary new at: 'key' put: 'b'; yourself).
	query := MongoQuery new
		database: database;
		collection: collection;
		where: Dictionary new;
		order: { 'key' -> Mongo ascending} asDictionary.
	results := query perform.
	self assert: (results first at: 'key') equals: 'a'.