accessing
staleness
	^ isMaster isReplicaSet
		ifTrue: [ isMaster staleness ]
		ifFalse: [ 0 seconds ]