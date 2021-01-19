private
forkWritingLoop

	[ [ client isStarted ] whileTrue: [
		self writeWithRetry.
		self writingLoopInterval wait ] ] fork.
