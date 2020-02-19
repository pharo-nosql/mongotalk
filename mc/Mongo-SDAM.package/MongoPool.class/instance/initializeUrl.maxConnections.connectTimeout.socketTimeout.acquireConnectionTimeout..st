initialization
initializeUrl: aZnUrl maxConnections: aQuantity connectTimeout: aConnectTimeout socketTimeout: aSocketTimeout acquireConnectionTimeout: anAcquireConnectionTimeout
	self initialize.

	url := aZnUrl.
	maxConnections := aQuantity.
	connectTimeout := aConnectTimeout.
	socketTimeout := aSocketTimeout.
	acquireConnectionTimeout := anAcquireConnectionTimeout.

	connectionsSemaphore := Semaphore new.
	mutex := Mutex new.
	connections := LinkedList new.

	self resetAll.
