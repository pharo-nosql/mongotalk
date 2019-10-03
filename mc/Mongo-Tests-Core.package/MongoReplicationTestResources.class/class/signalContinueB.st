stop/continue
signalContinueB
	^ self
		pkillMongodAt: self mongoUrlB
		with: self signalNumberForContinue