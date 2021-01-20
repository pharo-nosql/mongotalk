private
forkReadingLoop

	[ [ client isStarted ] whileTrue: [
		self readWithRetry.
		self readingLoopInterval wait ] ] fork.
