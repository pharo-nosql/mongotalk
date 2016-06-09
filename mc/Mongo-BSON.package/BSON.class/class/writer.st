instance creation
writer
	^self new setStream: (LittleEndianStream on: ByteArray new writeStream)