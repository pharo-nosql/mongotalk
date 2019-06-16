initialization
initializeUrl: aZnUrl
	self initialize.

	monitor := Monitor new.
	connections := LinkedList new.

	url := aZnUrl.