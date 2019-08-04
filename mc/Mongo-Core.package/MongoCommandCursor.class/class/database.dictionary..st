instance creation
database: aMongoDatabase dictionary: aCollection 
	^ self basicNew
		initializeDatabase: aMongoDatabase
		command: aCollection;
		yourself.
