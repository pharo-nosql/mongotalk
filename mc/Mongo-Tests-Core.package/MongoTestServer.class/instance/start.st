start/stop
start
	self ensureTerminated.
	self ensureDirectoryCreated.
	process := [ self runOsProcess ] forkNamed: self asString