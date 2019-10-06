replica set
isPrimary
	^ self isMaster and: [ self isReplicaSet ]