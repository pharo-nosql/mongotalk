accessing
timeoutMilliSeconds
	^ timeoutMilliSeconds
		ifNil: [ client serverSelectionTimeout asMilliSeconds ]