operations
databases
	| raw aDictionary |
	aDictionary := (Dictionary new)
				at: 'listDatabases' put: 1;
				yourself.
	raw := (self admin command: aDictionary) at: 'databases'.
	^raw collect: [:each | self databaseNamed: (each at: 'name')]