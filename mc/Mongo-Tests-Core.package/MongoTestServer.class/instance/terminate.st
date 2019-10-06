start/stop
terminate
	self assert: self isStarted.
	
	osProcess terminate.
	osProcess := nil.

	process terminate.
	process := nil.