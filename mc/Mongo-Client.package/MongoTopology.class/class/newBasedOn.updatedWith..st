instance creation
newBasedOn: aMongoTopology updatedWith: aMongoServerDescription
	^ self basicNew
		initializeBasedOn: aMongoTopology
			updatedWith: aMongoServerDescription;
		yourself