accessing - server selection
localThreshold
	^ localThreshold ifNil: [
		localThreshold := SmallInteger maxVal seconds ]