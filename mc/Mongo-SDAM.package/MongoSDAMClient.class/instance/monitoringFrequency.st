accessing
monitoringFrequency
	^ self isMonitoringSteadyState
		ifTrue: [ self heartbeatFrequency ]
		ifFalse: [ self minHeartbeatFrequency ]