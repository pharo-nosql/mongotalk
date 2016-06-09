printing
printOn: aStream

	aStream 
		nextPutAll: 'Mongo (';
		nextPutAll: host asString;
		nextPut: $:;
		nextPutAll: port asString;
		nextPut: $)