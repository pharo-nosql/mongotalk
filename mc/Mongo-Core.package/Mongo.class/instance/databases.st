operations
databases
	^ self databaseNames collect: [ :each | self databaseNamed: each ]