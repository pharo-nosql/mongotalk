running
doReadOnClient: aMongoReadPreference
	client
		mongoDo: [ :mongo | ^ self doReadOnMongo: mongo ]
		readPreference: aMongoReadPreference