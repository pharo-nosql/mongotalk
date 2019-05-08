operations
ismaster

	| reply |
	reply := self command: (SmallDictionary new at: #ismaster put: 1; yourself).

	^ MongoIsmaster with: reply