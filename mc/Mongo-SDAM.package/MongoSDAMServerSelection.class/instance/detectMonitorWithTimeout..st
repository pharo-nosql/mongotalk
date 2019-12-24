public
detectMonitorWithTimeout: aDuration
	"Detect a monitor that satisfy the readPreference and localThreshold, signalling MongoSDAMServerSelectionTimeout if none is found."
	
	| startMS |
	startMS := Time millisecondClockValue.
	[
		readPreference accept: self.
		chosenMonitor ifNotNil: [ :found | ^ found ].

		client minHeartbeatFrequency wait.
		(Time millisecondsSince: startMS) >= aDuration asMilliSeconds
			ifTrue: [ ^ MongoSDAMServerSelectionTimeout signal ]

	] repeat