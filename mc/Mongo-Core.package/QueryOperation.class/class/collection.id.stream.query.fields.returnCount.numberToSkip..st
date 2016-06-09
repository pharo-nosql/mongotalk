instance creation
collection: aString id: idInteger stream: aStream query: queryDictionary fields: fieldsDictionary returnCount: countInteger numberToSkip: skipInteger
	self deprecated: 'Should be replaced by id:stream:query:'.
	^(self
		collection: aString 
		id: idInteger 
		stream: aStream)
			setQuery: queryDictionary 
			fields: fieldsDictionary 
			returnCount: countInteger
			numberToSkip: skipInteger