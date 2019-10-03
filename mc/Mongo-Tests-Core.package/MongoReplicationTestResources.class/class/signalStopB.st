stop/continue
signalStopB
	^ self
		pkillMongodAt: self mongoUrlB
		with: self signalNumberForStop