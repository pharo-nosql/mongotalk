instance creation
newFromFindResponse: aDictionary

	| cursorDictionary |
	cursorDictionary := aDictionary at: 'cursor'.
	^ self basicNew
		initializeWithDocuments: (cursorDictionary at: 'firstBatch')
		cursorId: (cursorDictionary at: 'id');
		yourself