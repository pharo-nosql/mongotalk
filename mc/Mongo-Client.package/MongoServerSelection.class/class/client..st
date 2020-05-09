instance creation
client: aClient
	^ self basicNew
		initializeWithClient: aClient;
		yourself