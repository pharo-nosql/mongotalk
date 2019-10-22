instance creation
url: aZnUrl maxConnections: aQuantity connectTimeout: aDuration socketTimeout: anotherDuration
	^ self basicNew
		initializeUrl: aZnUrl
			maxConnections: aQuantity
			connectTimeout: aDuration
			socketTimeout: anotherDuration;
		yourself