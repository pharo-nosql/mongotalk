initialization
initializeUrl: aZnUrl maxConnections: aQuantity connectTimeout: aConnectTimeout socketTimeout: aSocketTimeout
	self initialize.

	url := aZnUrl.
	maxConnections := aQuantity.
	connectTimeout := aConnectTimeout.
	socketTimeout := aSocketTimeout.

	mutex := Mutex new.
	connections := LinkedList new.

	self resetAll.
