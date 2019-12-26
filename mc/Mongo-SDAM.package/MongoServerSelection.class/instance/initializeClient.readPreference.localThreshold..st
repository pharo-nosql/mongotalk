initialization
initializeClient: aSDAMClient readPreference: aReadPreference localThreshold: localThresholdDuration
	self initialize.
	client := aSDAMClient.
	readPreference := aReadPreference.
	localThreshold := localThresholdDuration