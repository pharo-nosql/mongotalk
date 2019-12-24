accessing
localThreshold
	^ localThreshold ifNil: [
		localThreshold := SmallInteger maxVal seconds ]