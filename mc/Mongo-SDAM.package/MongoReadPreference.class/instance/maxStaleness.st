accessing
maxStaleness
	^ maxStaleness ifNil: [ maxStaleness := SmallInteger maxVal seconds ]