operations
lastError
	| reply |
	reply := self command: {'getLastError'->1} asDictionary.
	
	^ MongoLastError newFor: reply