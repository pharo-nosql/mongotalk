accessing
maxConnections
	^ maxConnections ifNil: [ self defaultMaxConnections ]