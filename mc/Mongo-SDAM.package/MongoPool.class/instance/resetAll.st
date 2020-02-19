accessing
resetAll
	"Remove and close all connections."
	
	mutex critical: [
		[ connections isEmpty ] whileFalse: [
			self ensureCloseMongo: connections removeLast ].

		connectionsSemaphore consumeAllSignals.
		maxConnections timesRepeat: [ connectionsSemaphore signal ].
		]