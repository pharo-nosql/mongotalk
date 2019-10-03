private - server selection
detectMonitorFor: aReadPreference localThreshold: localThresholdDuration ifFound: foundBlockClosure ifNone: noneBlockClosure in: someMonitors
	"Detect a monitor among someMonitors for the received arguments, and evaluate the received blocks accordingly to the detection result."
	
	| eligibleMonitors latencyWindowLowerBound latencyWindowUpperBound |
	eligibleMonitors := someMonitors.
	eligibleMonitors ifEmpty: [ ^ noneBlockClosure value ].

	"Filter by latency window"
	latencyWindowLowerBound := (eligibleMonitors collect: [ :each | each roundtripDurationAverage ]) min.
	latencyWindowUpperBound := latencyWindowLowerBound + localThresholdDuration.
	eligibleMonitors := eligibleMonitors select: [ :each |
		each roundtripDurationAverage <= latencyWindowUpperBound ].

	"Filter by staleness"
	aReadPreference hasMaxStalenessValue ifTrue: [
		eligibleMonitors := eligibleMonitors select: [ :each |
			each latestServerDescription staleness <= aReadPreference maxStaleness ] ].

	^ eligibleMonitors
		ifEmpty: noneBlockClosure
		ifNotEmpty: [ foundBlockClosure value: (eligibleMonitors atRandom: self serverSelectionRandomGenerator) ]
