instance creation
newFromFirstBatchResponse: aDictionary

	| cursorDictionary |
	cursorDictionary := aDictionary at: 'cursor'.
	^ self basicNew
		initializeWithCollectionName: (cursorDictionary at: 'ns')
		documents: (cursorDictionary at: 'firstBatch')
		cursorId: (cursorDictionary at: 'id');
		yourself