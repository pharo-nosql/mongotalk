writing
writeBody
	writer
		nextInt32Put: self flags;
		nextEncodedStringPut: collectionBytes;
		nextInt32Put: mongoQuery offset; "number of elements to skip"
		nextInt32Put: mongoQuery chunkSize;
		nextBytesPut: self dataBytes.
		
		"order is to be integrated in the dataBytes"