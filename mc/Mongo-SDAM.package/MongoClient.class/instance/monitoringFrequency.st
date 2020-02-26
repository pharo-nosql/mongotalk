accessing
monitoringFrequency
	^ self isMonitoringSteadyState
		ifTrue: [ settings heartbeatFrequency ]
		ifFalse: [ settings minHeartbeatFrequency ]