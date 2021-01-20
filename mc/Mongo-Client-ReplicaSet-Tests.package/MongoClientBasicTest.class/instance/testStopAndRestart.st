tests
testStopAndRestart
	
	client := self newClient.
	self startClientAndWait.
	self assert: client isStarted.

	client stop.
	1 second wait.
	self deny: client isStarted.

	self startClientAndWait.
	self assert: client isStarted.
