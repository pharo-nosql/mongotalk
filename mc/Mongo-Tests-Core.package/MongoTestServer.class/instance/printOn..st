printing
printOn: aStream
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: port;
		space;
		nextPutAll: (self isStarted ifTrue: 'ON' ifFalse: 'OFF');
		nextPut: $)