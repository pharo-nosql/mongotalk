instance creation
client: aSDAMClient readPreference: aReadPreference localThreshold: localThresholdDuration
	^ self basicNew
		initializeClient: aSDAMClient readPreference: aReadPreference localThreshold: localThresholdDuration;
		yourself