accessing
monitoringFrequency
	^ (topology isTypeReplicaSetWithPrimary or: [ topology isTypeSingle ])
		ifTrue: [ self steadyStateFrequency ]
		ifFalse: [ self crisisStateFrequency ]