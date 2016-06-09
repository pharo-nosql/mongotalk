operations
queryOne: aMongoQuery
	aMongoQuery database: self.
	^root queryOne: aMongoQuery.