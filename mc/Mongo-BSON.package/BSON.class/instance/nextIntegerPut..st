writing
nextIntegerPut: anInteger
	"Seems like this belongs here instead of the caller or the stream, but not certain"

	(self isInt32: anInteger) ifTrue: [^stream nextInt32Put: anInteger].
	(self isInt64: anInteger) ifTrue: [^stream nextInt64Put: anInteger].
	BSONError signal: 'Integer too large: ' , anInteger printString