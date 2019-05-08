accessing
stop
	process ifNotNil: [
		process terminate.
		process := nil ].
	self ensureMongoClosed.