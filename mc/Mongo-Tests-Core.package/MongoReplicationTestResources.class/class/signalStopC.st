stop/continue
signalStopC
	^ self
		pkillMongodAt: self mongoUrlC
		with: self signalNumberForStop