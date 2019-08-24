private
detectSecondaryPoolFor: aReadPreference localThreshold: localThresholdDuration ifFound: foundBlockClosure ifNone: noneBlockClosure
	"Detect a pool for secondary servers and evaluate the blocks accordingly.
	
	Sources: 
	* https://docs.mongodb.com/manual/core/read-preference-mechanics/
	* https://www.mongodb.com/blog/post/server-selection-next-generation-mongodb-drivers
	* https://github.com/mongodb/specifications/blob/master/source/max-staleness/max-staleness.rst#maxstalenessseconds-is-part-of-read-preferences
	"
	
	^ topology secondaryUrlStrings
		ifEmpty: noneBlockClosure
		ifNotEmpty: [ :urlsStrings |
			| eligibleMonitors latencyWindowUpperBound elegibleMonitorsInLatencyWindow |
			eligibleMonitors := (SortedCollection new: urlsStrings size)
				sortBlock: [ :a :b | a roundtripDurationAverage <= b roundtripDurationAverage ].
			urlsStrings do: [ :each | eligibleMonitors add: (monitors at: each) ].

			"There must be at least 1 monitor. This formula is defined by the Server Selection specifications."
			latencyWindowUpperBound := eligibleMonitors first roundtripDurationAverage + localThresholdDuration.
			elegibleMonitorsInLatencyWindow := eligibleMonitors 
				select: [:each | each roundtripDurationAverage <= latencyWindowUpperBound ].

			self flag: #todo. "Also filter by maxStalenessSeconds and tag sets"

			foundBlockClosure value: elegibleMonitorsInLatencyWindow atRandom pool ]