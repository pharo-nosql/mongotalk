accessing - pool
socketTimeout
	^ socketTimeout ifNil: [
		socketTimeout := 5 seconds ]