private - server selection
detectMonitorFor: aReadPreference localThreshold: localThresholdDuration ifFound: foundBlockClosure ifNone: noneBlockClosure
	"Detect a monitor for the received arguments, and evaluate the received blocks accordingly to the detection result."
	
	(aReadPreference isTypePrimary and: [ topology hasPrimary ]) ifTrue: [
		^ foundBlockClosure value: (monitors at: topology primaryUrlString) ].

	aReadPreference isTypePrimaryPreferred ifTrue: [
		^ topology hasPrimary
			ifTrue: [
				foundBlockClosure value: (monitors at: topology primaryUrlString) ]
			ifFalse: [
				| successfulSecondaryMonitors |
				successfulSecondaryMonitors := topology successfulSecondaryServers
					collect: [ :each | monitors at: each urlString ].
				self
					detectMonitorFor: aReadPreference
					localThreshold: localThresholdDuration
					ifFound: foundBlockClosure
					ifNone: noneBlockClosure
					in: successfulSecondaryMonitors ] ].

	^ noneBlockClosure value