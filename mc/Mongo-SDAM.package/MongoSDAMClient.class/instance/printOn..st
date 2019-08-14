printing
printOn: aStream
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: (self isStarted ifTrue: 'started' ifFalse: 'stopped');
		nextPutAll: ' - ';
		print: topology serversUrlStrings size;
		nextPutAll: ' servers)'
		