as yet unclassified
concernForGetLastError
	| dict |
	dict := { 
		'getLastError' -> 1.
	} asDictionary.
	self wValue ifNotNil: [:val |
		dict at: 'w' put: val].
	self jValue ifNotNil: [:val |
		dict at: 'j' put: val].
	self wtimeoutValue ifNotNil: [:val |
		dict at: 'wtimeout' put: val].
	^dict