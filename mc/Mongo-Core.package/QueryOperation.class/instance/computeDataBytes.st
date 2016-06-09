writing
computeDataBytes
	| queryDictionary |
	queryDictionary := Dictionary new
		at: '$query' put: mongoQuery where;
		yourself.
	mongoQuery order ifNotNil: [
		queryDictionary at: '$orderby' put: mongoQuery order].
	
	^mongoQuery fields 
		ifNotNil: [BSON writeAll: { queryDictionary . mongoQuery fields}]
		ifNil: [BSON write: queryDictionary]