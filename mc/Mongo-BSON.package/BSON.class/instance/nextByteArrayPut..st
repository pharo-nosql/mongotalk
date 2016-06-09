writing
nextByteArrayPut: aByteArray
	stream 
		nextInt32Put: aByteArray size;
		nextBytePut: 0; "Subtype: Binary / Generic"
		nextBytesPut: aByteArray