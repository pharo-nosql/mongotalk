initialization
initializeUrl: aZnUrl maxConnections: aQuantity connectTimeout: aDuration socketTimeout: anotherDuration
	self initialize.
	url := aZnUrl.
	maxConnections := aQuantity.
	connectTimeout := aDuration.
	socketTimeout := anotherDuration.

	mutex := Mutex new.
	connections := LinkedList new