accessing
maxConnections
	^ maxConnections ifNil: [ maxConnections := 25 ]