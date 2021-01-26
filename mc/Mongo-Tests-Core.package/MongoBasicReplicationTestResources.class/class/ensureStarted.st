stop/continue
ensureStarted
	replicaSet
		ifNil: [ self start ]
		ifNotNil: [ replicaSet ensureAllServersStarted ]