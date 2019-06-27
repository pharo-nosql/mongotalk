accessing
detectPoolWithTimeoutFor: aReadPreference

	| startMS |
	startMS := Time millisecondClockValue.
	[	self
			detectPoolFor: readPreference
			ifFound: [ :aPool | ^ aPool ]
			ifNone: [
				self restart.
				self crisisStateFrequency wait ].
	] doWhileTrue: [ serverSelectionTimeoutMS > (Time millisecondsSince: startMS) ].

	MongoSDAMServerSelectionTimeout signal