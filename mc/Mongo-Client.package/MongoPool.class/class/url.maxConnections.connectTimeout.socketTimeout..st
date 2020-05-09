instance creation
url: aZnUrl maxConnections: aQuantity connectTimeout: aConnectTimeout socketTimeout: aSocketTimeout
	^ self basicNew
		initializeUrl: aZnUrl
			maxConnections: aQuantity
			connectTimeout: aConnectTimeout
			socketTimeout: aSocketTimeout;
		yourself