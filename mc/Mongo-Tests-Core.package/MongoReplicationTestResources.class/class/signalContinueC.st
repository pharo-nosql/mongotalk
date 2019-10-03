stop/continue
signalContinueC
	^ self
		pkillMongodAt: self mongoUrlC
		with: self signalNumberForContinue