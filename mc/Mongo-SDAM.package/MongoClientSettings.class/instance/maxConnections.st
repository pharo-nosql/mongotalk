accessing - pool
maxConnections
	^ maxConnections ifNil: [ maxConnections := 25 ]