operations
lastError
	| reply |
	reply := self command: (OrderedIdentityDictionary new at: #getLastError put: 1; yourself).
	
	^ MongoLastError newFor: reply