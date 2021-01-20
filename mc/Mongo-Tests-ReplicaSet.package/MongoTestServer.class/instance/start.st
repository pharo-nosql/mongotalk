start/stop
start
	self ensureTerminated.
	self ensureDirectoryCreated.
	osProcess := self newOsProcess.
	process := [ self runOsProcess ] forkNamed: self asString