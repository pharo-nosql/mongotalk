operations
databases
	| raw command |
	command := (OrderedIdentityDictionary new)
				at: #listDatabases put: 1;
				yourself.
	raw := (self admin command: command) at: 'databases'.
	^raw collect: [:each | self databaseNamed: (each at: 'name')]