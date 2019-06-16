private
returnConnection: mongo
	monitor critical: [
		connections size >= self maxConnections
			ifTrue: [ self ensureCloseMongo: mongo ]
			ifFalse: [ connections add: mongo ] ]