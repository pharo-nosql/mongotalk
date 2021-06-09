accessing
stop
	process ifNotNil: [
		process terminate.
		process := nil ].
	self ensureMongoIsClosed.
	pool resetAll.