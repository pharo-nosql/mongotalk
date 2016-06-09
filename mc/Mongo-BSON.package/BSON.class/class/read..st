codec
read: aStream
	| reader |
	reader := LittleEndianStream on: aStream.
	^(self new setStream: reader) nextDictionary