printing
printOn: aStream 
	aStream 
		nextPut: $/;
		nextPutAll: self value;
		nextPut: $/;
		nextPut: $i