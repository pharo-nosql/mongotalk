instance creation
newBasedOn: aMongoSDAMTopology updatedWith: aMongoSDAMServerDescription
	^ self basicNew
		initializeBasedOn: aMongoSDAMTopology
			updatedWith: aMongoSDAMServerDescription;
		yourself