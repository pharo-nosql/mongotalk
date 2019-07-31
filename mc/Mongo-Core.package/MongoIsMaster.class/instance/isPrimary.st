replica set
isPrimary
	^ (response at: 'ismaster') and: [ self isReplicaSet ]