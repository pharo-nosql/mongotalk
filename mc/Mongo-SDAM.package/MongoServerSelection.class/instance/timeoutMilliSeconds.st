accessing
timeoutMilliSeconds
	^ timeoutMilliSeconds
		ifNil: [ client settings serverSelectionTimeout asMilliSeconds ]