running
tearDown
	super tearDown.
	
	client ifNotNil: [
		client
			mongoDo: [ :mongo | (mongo databaseNamed: self databaseNameForTesting) drop ];
			stop ]