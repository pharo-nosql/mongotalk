private
detectPoolFor: aReadPreference localThreshold: localThresholdDuration ifFound: foundBlockClosure ifNone: noneBlockClosure
	
	(aReadPreference = MongoReadPreference primary and: [ topology hasPrimary ])
		ifTrue: [ ^ foundBlockClosure value: (monitors at: topology primaryUrlString) pool ].

	aReadPreference = MongoReadPreference primaryPreferred
		ifTrue: [ ^ topology hasPrimary
			ifTrue: [ foundBlockClosure value: (monitors at: topology primaryUrlString) pool ]
			ifFalse: [ self
				detectSecondaryPoolFor: aReadPreference
				localThreshold: localThresholdDuration
				ifFound: foundBlockClosure
				ifNone: noneBlockClosure ] ].

	^ noneBlockClosure value