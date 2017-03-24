accessing
errorMessage
	^ reply at: 'errmsg' ifAbsent: 'unknown'