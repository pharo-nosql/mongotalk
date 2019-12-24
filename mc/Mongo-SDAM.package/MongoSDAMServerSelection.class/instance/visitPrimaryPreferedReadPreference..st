visiting
visitPrimaryPreferedReadPreference: aReadPreference
	client topology hasPrimary
		ifTrue: [ client primaryMonitor ]
		ifFalse: [ self randomlyChooseEligibleMonitorIn: client successfulSecondaryMonitors ]