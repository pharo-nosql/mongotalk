operations
listDatabases
	| raw command |
	command := (OrderedIdentityDictionary new)
				at: #listDatabases put: 1;
				yourself.
	raw := (self admin command: command) at: 'databases'.
	^ raw