operations
commandAndVerify: anOrderedDictionary
	| res |
	res := root command: anOrderedDictionary database: self.
	res at: 'writeConcernError' ifPresent: [:err |
		MongoCommandError signalFor: err].
	res at: 'writeErrors' ifPresent: [:errors |
		MongoCommandError signalFor: errors last].
	^ res