accessing
detectSecondaryPoolFor: aReadPreference ifFound: foundBlockClosure ifNone: noneBlockClosure
	"Source: https://docs.mongodb.com/manual/core/read-preference-mechanics/"
	
	^ topology secondaryUrlStrings
		ifEmpty: noneBlockClosure
		ifNotEmpty: [ :urlsStrings |
			| eligible |
			eligible := urlsStrings collect: [ :each | monitors at: each ].
			self flag: #todo. "Filter by maxStalenessSeconds and tag sets"
			self flag: #todo. "Sort by latency, etc."

			foundBlockClosure value: eligible anyOne pool ]