visiting
visitPrimaryPreferedReadPreference: aReadPreference
	^ client topology hasPrimary
		ifTrue: [ client primaryMonitor ]
		ifFalse: [ self randomEligibleMonitorOrNilIn: client successfulSecondaryMonitors ]