private
randomEligibleMonitorOrNilIn: someMonitors
	"Detect a monitor that satisfy the readPreference and localThreshold."
	
	| eligibleMonitors latencyWindowLowerBound latencyWindowUpperBound |
	eligibleMonitors := someMonitors.
	eligibleMonitors ifEmpty: [ ^ nil ].

	"Filter by staleness"
	self readPreference hasMaxStalenessValue ifTrue: [
		eligibleMonitors := eligibleMonitors select: [ :each |
			each staleness <= self readPreference maxStaleness ] ].
	eligibleMonitors ifEmpty: [ ^ nil ].

	"TODO: filter by tag set (https://docs.mongodb.com/v4.0/core/read-preference/#tag-set)"

	"Filter by latency window"
	latencyWindowLowerBound := (eligibleMonitors collect: [ :each | each roundtripDurationAverage ]) min.
	latencyWindowUpperBound := latencyWindowLowerBound + self localThreshold.
	eligibleMonitors := eligibleMonitors select: [ :each |
		each roundtripDurationAverage <= latencyWindowUpperBound ].
	eligibleMonitors ifEmpty: [ ^ nil ].

	"Finally, choose one."
	^ eligibleMonitors atRandom: client serverSelectionRandomGenerator
