public
execute
	"Detect a monitor that satisfy the readPreference and localThreshold, signalling MongoSDAMServerSelectionTimeout if none is found."
	
	| startMS |
	startMS := Time millisecondClockValue.
	[
		"TODO: don't use nil as answer..."
		selectedMonitor := self readPreference accept: self.
		selectedMonitor ifNotNil: [ :monitor | ^ monitor ].

		client minHeartbeatFrequency wait.
		(Time millisecondsSince: startMS) >= self timeoutMilliSeconds
			ifTrue: [ ^ MongoServerSelectionTimeout signal ]

	] repeat