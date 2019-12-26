accessing
socketTimeout
	^ socketTimeout ifNil: [
		socketTimeout := 5 seconds ]