writing
writeBody
	writer
		nextInt32Put: 0;
		nextEncodedStringPut: collectionBytes;
		nextInt32Put: self flags;
		nextBytesPut: self dataBytes