instance creation
for: aMongoClient
	^ self basicNew
		initializeWith: aMongoClient;
		yourself