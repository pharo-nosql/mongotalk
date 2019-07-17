tests
testCommandGetMore
	| data queryBatch cursorId batch |
	self assert: collection size equals: 0.
	data := Dictionary new at: 'key' put: 'value'; yourself.
	150 timesRepeat: [ collection add: data ].
	self assert: collection size equals: 150.

	queryBatch := collection commandFind: data readConcern: nil.
	
	batch := queryBatch documents.
	self assert: batch size equals: 101.
	self assert: (batch first at: 'key') equals: 'value'.
	
	cursorId := queryBatch cursorIdForNextBatch.
	self assert: cursorId > 0. "It's zero when there are no more pages"
					
	queryBatch := collection commandGetMore: cursorId batchSize: nil timeout: nil.

	batch := queryBatch documents.
	self assert: batch size equals: 49.
	self assert: (batch first at: 'key') equals: 'value'.
	
	cursorId := queryBatch cursorIdForNextBatch.
	self assert: cursorId equals: 0. "It's zero when there are no more pages"
