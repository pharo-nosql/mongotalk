operations
commandUpdate: origDictionary with: newDictionary collection: collectionName 
	^self commandUpdate: origDictionary with: newDictionary collection: collectionName writeConcern: nil.