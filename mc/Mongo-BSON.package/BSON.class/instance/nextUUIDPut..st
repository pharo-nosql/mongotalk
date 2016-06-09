writing
nextUUIDPut: aUUID
	stream 
		nextInt32Put: aUUID size;
		"write new UUIDs with the actual assigned subtype"
		nextBytePut: 4;
		nextBytesPut: aUUID 