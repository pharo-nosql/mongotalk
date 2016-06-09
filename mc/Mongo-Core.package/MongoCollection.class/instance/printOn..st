printing
printOn: aStream
	"Prints the receiver on a stream"
	
	aStream nextPutAll: name asString
