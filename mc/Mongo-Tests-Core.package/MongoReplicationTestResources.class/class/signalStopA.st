stop/continue
signalStopA
	^ (replicaSet serverAtUrl: self mongoUrlA) sigstop