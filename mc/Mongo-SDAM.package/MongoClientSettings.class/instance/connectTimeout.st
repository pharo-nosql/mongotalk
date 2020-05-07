accessing - pool
connectTimeout
	^ connectTimeout ifNil: [
		connectTimeout := 10 seconds ]