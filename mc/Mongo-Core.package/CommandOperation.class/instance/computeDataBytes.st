writing
computeDataBytes
	^BSON writer 
		nextOrderedDictionaryPut: mongoQuery where; 
		contents