testing
isMonitoringSteadyState
	^ topology isTypeReplicaSetWithPrimary or: [ topology isTypeSingle ]