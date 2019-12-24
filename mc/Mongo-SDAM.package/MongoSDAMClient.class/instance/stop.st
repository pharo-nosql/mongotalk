API
stop
	monitors valuesDo: [ :each |
		each isRunning ifTrue: [
			each stop waitForCompletion: self monitorStopTimeout ] ].
