stop/continue
signalContinueA
	^ self
		pkillMongodAt: self mongoUrlA
		with: self signalNumberForContinue