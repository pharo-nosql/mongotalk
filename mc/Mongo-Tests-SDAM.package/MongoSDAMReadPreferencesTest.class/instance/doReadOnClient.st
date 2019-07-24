running
doReadOnClient
	client mongoDo: [ :mongo | ^ self doReadOnMongo: mongo ].
	^ nil