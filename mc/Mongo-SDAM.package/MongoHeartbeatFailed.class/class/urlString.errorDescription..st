instance creation
urlString: aUrlString errorDescription: aString
	^ self basicNew
		initializeWithUrlString: aUrlString errorDescription: aString;
		yourself