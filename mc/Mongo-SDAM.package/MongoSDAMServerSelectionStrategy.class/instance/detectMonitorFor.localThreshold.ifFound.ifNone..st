private - server selection
detectMonitorFor: aReadPreference localThreshold: localThresholdDuration ifFound: foundBlockClosure ifNone: noneBlockClosure
	"Detect a monitor for the received arguments, and evaluate the received blocks accordingly to the detection result."
	
	(aReadPreference isTypePrimary and: [ client topology hasPrimary ]) ifTrue: [
		^ foundBlockClosure value: client primaryMonitor ].

	aReadPreference isTypePrimaryPreferred ifTrue: [
		^ client topology hasPrimary
			ifTrue: [
				foundBlockClosure value: client primaryMonitor ]
			ifFalse: [
				self
					detectMonitorFor: aReadPreference
					localThreshold: localThresholdDuration
					ifFound: foundBlockClosure
					ifNone: noneBlockClosure
					in: client successfulSecondaryMonitors ] ].

	aReadPreference isTypeNearest ifTrue: [
		^ self
			detectMonitorFor: aReadPreference
			localThreshold: localThresholdDuration
			ifFound: foundBlockClosure
			ifNone: noneBlockClosure
			in: client successfulMonitors ].

	^ noneBlockClosure value