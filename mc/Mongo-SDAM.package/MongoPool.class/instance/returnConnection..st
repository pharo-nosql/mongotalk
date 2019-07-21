private
returnConnection: mongo
	monitor critical: [
		connections size >= self maxConnections
			ifTrue: [ mongo closeIfOpen ]
			ifFalse: [ connections add: mongo ] ]