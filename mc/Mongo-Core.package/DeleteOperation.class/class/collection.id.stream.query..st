instance creation
collection: aString id: idInteger stream: aStream query: aDictionary
	^(self
		collection: aString 
		id: idInteger 
		stream: aStream)
			setQuery: aDictionary