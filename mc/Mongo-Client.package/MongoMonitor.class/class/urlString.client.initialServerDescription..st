instance creation
urlString: urlString client: aMongoClient initialServerDescription: aMongoServerDescription
	^ self basicNew
		initializeUrlString: urlString
			client: aMongoClient
			initialServerDescription: aMongoServerDescription;
		yourself