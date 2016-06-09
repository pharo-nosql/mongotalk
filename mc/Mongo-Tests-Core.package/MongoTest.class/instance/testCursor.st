tests
testCursor
	| count data |
	self assert: collection size equals: 0.
	data := Dictionary new at: 'key' put: 'value'; yourself.
	4 timesRepeat: [collection add: data].
	self assert: collection size equals: 4.
	count := 0.
	(MongoCursor root: root query: (
		MongoQuery new
			database: database;
			collection: collection;
			where: data;
			doBlock: [:each | count := count + 1 ];
			chunkSize: 2;
			yourself)) execute.
	self assert: count equals: 4