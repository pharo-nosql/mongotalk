writing
writeBody
	writer
		nextInt32Put: 0;
		nextEncodedStringPut: collectionBytes;
		nextBytesPut: self dataBytes