operations
isMaster

	| reply |
	reply := self command: (SmallDictionary new at: #ismaster put: 1; yourself).

	^ MongoIsMaster with: reply