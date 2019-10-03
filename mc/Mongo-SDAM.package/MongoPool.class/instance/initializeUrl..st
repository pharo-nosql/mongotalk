initialization
initializeUrl: aZnUrl
	self initialize.

	url := aZnUrl.

	mutex := Mutex new.
	connections := LinkedList new.
	maxConnections := self defaultMaxConnections.
	connectTimeout := self defaultConnectTimeout.
	socketTimeout := self defaultSocketTimeout.
	
