running
doRead
	client mongoDo: [ :mongo | ^ self doReadOnMongo: mongo ].
	^ self fail