operations
queryOne: aMongoQuery
	aMongoQuery doBlock: [:each | ^each].
	aMongoQuery chunkSize: 1.
	(MongoCursor new
		root: self;
		query: aMongoQuery;
		execute).
	^nil