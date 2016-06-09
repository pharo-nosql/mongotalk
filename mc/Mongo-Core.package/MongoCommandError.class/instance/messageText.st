accessing
messageText
	^ reply at: 'errmsg' ifAbsent: 'unknown'