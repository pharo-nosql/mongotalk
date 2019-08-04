operations
getCollection: aString
	^ (self collectionAt: aString)
		ensureAdded;
		yourself