enumerating
do: aBlockClosure 
	batch := MongoQueryBatch newFromFindResponse: (database command: command).

	[	batch documents do: aBlockClosure.
		batch atEnd ifTrue: [ ^self ].
		batch := (database collectionAt: batch collectionName) commandGetMore: batch cursorId batchSize: self batchSizeOrNil timeout: self timeoutOrNil
		] repeat