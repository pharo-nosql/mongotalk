initialization
initializeDatabase: aMongoDatabase command: aCollection 
	self initialize.
	
	database := aMongoDatabase.
	command := aCollection.