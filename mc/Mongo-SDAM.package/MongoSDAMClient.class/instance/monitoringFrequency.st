accessing
monitoringFrequency
	^ self isMonitoringSteadyState
		ifTrue: [ self steadyStateFrequency ]
		ifFalse: [ self crisisStateFrequency ]