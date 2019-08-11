operations
isMaster

	| reply |
	reply := self command: (OrderedDictionary new at: #ismaster put: 1; yourself).

	^ MongoIsMaster with: reply