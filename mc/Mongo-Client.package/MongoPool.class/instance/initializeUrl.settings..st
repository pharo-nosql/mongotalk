initialization
initializeUrl: aZnUrl settings: aMongoSettings
	self initialize.

	url := aZnUrl.
	settings := aMongoSettings.

	mutex := Mutex new.
	connections := LinkedList new.

	self resetAll.
