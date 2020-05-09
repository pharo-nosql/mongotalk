public
execute
	"Detect a monitor that satisfy the readPreference and localThreshold, signalling MongoServerSelectionTimeout if none is found."
	
	| startMS |
	startMS := Time millisecondClockValue.
	[
		self flag: #todo. "Don't use nil as answer..."
		selectedMonitor := self readPreference accept: self.
		selectedMonitor ifNotNil: [ :monitor | ^ monitor ].

		client settings minHeartbeatFrequency wait.
		(Time millisecondsSince: startMS) >= self timeoutMilliSeconds
			ifTrue: [ ^ MongoServerSelectionTimeout signal ]

	] repeat