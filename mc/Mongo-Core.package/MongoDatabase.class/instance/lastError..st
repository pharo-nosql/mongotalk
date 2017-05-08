operations
lastError: aConcern
	| reply |
	reply := self command: (aConcern
										ifNil: [{'getLastError'->1} asDictionary]
										ifNotNil: [:concern | concern concernForGetLastError]).

	^ MongoLastError newFor: reply