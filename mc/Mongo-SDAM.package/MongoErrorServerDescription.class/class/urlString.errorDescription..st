instance creation
urlString: urlString errorDescription: anErrorDescription
	^ self basicNew
		initializeUrlString: urlString errorDescription: anErrorDescription;
		yourself