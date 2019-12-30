start/stop
start
	self ensureTerminated.
	self ensureDirectoryCreated.
	osProcess := self newOsProcess.