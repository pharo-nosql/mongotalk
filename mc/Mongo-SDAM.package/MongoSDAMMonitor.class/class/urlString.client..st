instance creation
urlString: urlString client: aMongoSDAMClient
	^ self basicNew
		initializeUrlString: urlString client: aMongoSDAMClient;
		yourself