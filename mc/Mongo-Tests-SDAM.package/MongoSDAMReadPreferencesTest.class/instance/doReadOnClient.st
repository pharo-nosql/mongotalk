running
doReadOnClient
	client mongoDo: [ :mongo | ^ self doReadOnMongo: mongo ].
	^ self fail