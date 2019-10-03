printing
printOn: aStream
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: (self isStarted ifTrue: 'ON' ifFalse: 'OFF');
		nextPutAll: ', ';
		nextPutAll: urlString;
		nextPut: $).
