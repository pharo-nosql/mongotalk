start/stop
start
	self assert: self isStarted not.
	self ensureDirectoryCreated.
	osProcess := self newOsProcess.
	process := [ self runOsProcess ] forkNamed: self asString