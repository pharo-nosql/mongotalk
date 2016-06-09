printing
printOn: aStream 
	aStream 
		nextPut: $/;
		nextPutAll: self value asString;
		nextPut: $/;
		nextPut: $i