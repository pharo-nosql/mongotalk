accessing
replicaSetPassives
	^ response at: 'passives' ifAbsent: [ #() ]