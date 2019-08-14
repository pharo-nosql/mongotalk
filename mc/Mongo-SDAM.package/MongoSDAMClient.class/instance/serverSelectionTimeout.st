accessing
serverSelectionTimeout
	^ serverSelectionTimeout ifNil: [ 3 seconds ]