instance creation
url: aZnUrl settings: aMongoSettings
	^ self basicNew
		initializeUrl: aZnUrl
			settings: aMongoSettings;
		yourself