operations
listDatabases
	| command |
	command := (OrderedIdentityDictionary new)
				at: #listDatabases put: 1;
				yourself.
	^ (self admin command: command) at: 'databases'