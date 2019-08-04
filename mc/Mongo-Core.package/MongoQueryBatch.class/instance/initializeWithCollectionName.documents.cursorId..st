initialization
initializeWithCollectionName: aString documents: aCollection cursorId: anInteger
	self initialize.

	self flag: #todo. "This code removes the db name, and it's a bit strange to have it here."	
	collectionName := aString readStream upTo: $.; upToEnd.
	documents := aCollection.
	cursorId := anInteger.