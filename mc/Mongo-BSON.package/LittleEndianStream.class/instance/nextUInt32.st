reading
nextUInt32
	^stream next + (stream next bitShift: 8) + (stream next bitShift: 16) + (stream next bitShift: 24)