instance creation
url: aZnUrl maxConnections: aQuantity connectTimeout: aConnectTimeout socketTimeout: aSocketTimeout acquireConnectionTimeout: anAcquireConnectionTimeout
	^ self basicNew
		initializeUrl: aZnUrl
			maxConnections: aQuantity
			connectTimeout: aConnectTimeout
			socketTimeout: aSocketTimeout
			acquireConnectionTimeout: anAcquireConnectionTimeout;
		yourself