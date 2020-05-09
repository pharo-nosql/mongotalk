public API
startClientAndLoopReadingAndWriting
	client start.
	self forkReadingLoop.
	self forkWritingLoop.