accessing
maxStaleness
	^ maxStaleness ifNil: [ self maxStalenessNullValue ]