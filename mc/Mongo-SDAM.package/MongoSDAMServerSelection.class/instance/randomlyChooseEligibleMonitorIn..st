private
randomlyChooseEligibleMonitorIn: someMonitors
	"Detect a monitor that satisfy the readPreference and localThreshold."
	
	| eligibleMonitors latencyWindowLowerBound latencyWindowUpperBound |
	eligibleMonitors := someMonitors.
	eligibleMonitors ifEmpty: [ ^ self ].

	"Filter by staleness"
	readPreference hasMaxStalenessValue ifTrue: [
		eligibleMonitors := eligibleMonitors select: [ :each |
			each staleness <= readPreference maxStaleness ] ].
	eligibleMonitors ifEmpty: [ ^ self ].

	"TODO: filter by tag set (https://docs.mongodb.com/v4.0/core/read-preference/#tag-set)"

	"Filter by latency window"
	latencyWindowLowerBound := (eligibleMonitors collect: [ :each | each roundtripDurationAverage ]) min.
	latencyWindowUpperBound := latencyWindowLowerBound + localThreshold.
	eligibleMonitors := eligibleMonitors select: [ :each |
		each roundtripDurationAverage <= latencyWindowUpperBound ].

	eligibleMonitors ifNotEmpty: [
		chosenMonitor := eligibleMonitors atRandom: client serverSelectionRandomGenerator ]
