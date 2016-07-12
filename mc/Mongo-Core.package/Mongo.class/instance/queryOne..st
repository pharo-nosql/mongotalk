operations
queryOne: aMongoQuery
	aMongoQuery doBlock: [:each | 
		^(each includesKey: '$err')
			ifTrue: [ MongoQueryError signalFor: each ]
			ifFalse: [ each ] ].
	aMongoQuery chunkSize: 1.
	(MongoCursor new
		root: self;
		query: aMongoQuery;
		execute).
	^nil