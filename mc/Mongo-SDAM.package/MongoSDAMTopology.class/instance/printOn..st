printing
printOn: aStream
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	self serversUrlStrings printElementsOn: aStream.
