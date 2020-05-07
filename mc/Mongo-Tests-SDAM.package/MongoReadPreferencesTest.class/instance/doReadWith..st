running
doReadWith: aMongoReadPreference
	client
		mongoDo: [ :mongo | ^ self doReadOnMongo: mongo ]
		readPreference: aMongoReadPreference.
	self fail