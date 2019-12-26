instance creation
urlString: urlString client: aMongoSDAMClient initialServerDescription: aMongoSDAMServerDescription
	^ self basicNew
		initializeUrlString: urlString
			client: aMongoSDAMClient
			initialServerDescription: aMongoSDAMServerDescription;
		yourself