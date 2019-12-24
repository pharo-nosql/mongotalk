visiting
visitPrimaryReadPreference: aReadPreference
	client topology hasPrimary
		ifTrue: [ client primaryMonitor ]