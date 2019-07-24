instance creation
newFromGetMoreResponse: aDictionary

	| cursorDictionary |
	cursorDictionary := aDictionary at: 'cursor'.
	^ self basicNew
		initializeWithDocuments: (cursorDictionary at: 'nextBatch')
		cursorId: (cursorDictionary at: 'id');
		yourself