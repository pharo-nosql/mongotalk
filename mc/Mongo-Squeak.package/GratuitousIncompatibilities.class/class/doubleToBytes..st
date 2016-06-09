converting
doubleToBytes: aFloat
	| writer lowWord highWord |
	writer := LittleEndianStream on: (ByteArray new: 8) writeStream.
	lowWord := aFloat basicAt: 2.
	writer nextInt32Put: lowWord.
	highWord := aFloat basicAt: 1.
	writer nextInt32Put: highWord.
	^writer contents