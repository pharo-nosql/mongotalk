printing
printOn: aStream
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: urlString;
		space;
		print: (self isStarted ifTrue: 'active' ifFalse: 'idle');
		nextPut: $).
