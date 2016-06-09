tests
testSelectWithLimit
	| selected query |
	collection add: (Dictionary new at: 'key1' put: 'value1'; yourself).
	collection add: (Dictionary new at: 'key2' put: 'value2'; yourself).
	collection add: (Dictionary new at: 'key3' put: 'value3'; yourself).
	query := MongoQuery new
		database: database;
		collection: collection;
		limit: 2.
	selected := query perform.
	self assert: selected size equals: 2