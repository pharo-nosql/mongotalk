start/stop
ensureStarted
	self isStarted
		ifTrue: [ self sigcont "it may need it due to sigstop" ]
		ifFalse: [ self start ]
