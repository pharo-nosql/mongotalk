stop/continue
signalStopA
	^ self
		pkillMongodAt: self mongoUrlA
		with: self signalNumberForStop