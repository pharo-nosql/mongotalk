private-operations
sizeForQuery: aDictionary
	"Answer the count the number of matching documents in this collection.

	See more on https://docs.mongodb.com/v4.0/reference/command/count/"

	| reply |
	reply := database
		command:
			(OrderedIdentityDictionary new
				at: #count put: name;
				at: #query put: aDictionary;
				yourself)
		flags: QueryOperation flagSlaveOk.

	^ (reply at: 'n') asInteger	"Why in the world is it a double?"