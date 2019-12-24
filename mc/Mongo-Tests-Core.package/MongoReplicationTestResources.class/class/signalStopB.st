stop/continue
signalStopB
	^ (replicaSet serverAtUrl: self mongoUrlB) sigstop