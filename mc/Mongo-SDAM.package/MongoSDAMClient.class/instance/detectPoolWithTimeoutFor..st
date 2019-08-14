private
detectPoolWithTimeoutFor: aReadPreference

	| startMS serverSelectionTimeoutMS |
	startMS := Time millisecondClockValue.
	serverSelectionTimeoutMS := self serverSelectionTimeout asMilliSeconds.
	[	self
			detectPoolFor: self readPreference
			ifFound: [ :aPool | ^ aPool ]
			ifNone: [
				self restart.
				self crisisStateFrequency wait ].
	] doWhileTrue: [ serverSelectionTimeoutMS > (Time millisecondsSince: startMS) ].

	MongoSDAMServerSelectionTimeout signal