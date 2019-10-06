stop/continue
stop
	replicaSet ifNotNil: [
		replicaSet terminateAll.
		replicaSet := nil].