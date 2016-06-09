instance creation
id: idInteger stream: aStream query: aMongoQuery
	^(self
		collection: aMongoQuery qualifiedName 
		id: idInteger 
		stream: aStream)
			mongoQuery: aMongoQuery