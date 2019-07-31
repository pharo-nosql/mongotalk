instance creation
newFromGetMoreResponse: aDictionary

	| cursorDictionary |
	cursorDictionary := aDictionary at: 'cursor'.
	^ self basicNew
		initializeWithCollectionName: (cursorDictionary at: 'ns')
		documents: (cursorDictionary at: 'nextBatch')
		cursorId: (cursorDictionary at: 'id');
		yourself