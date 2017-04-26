as yet unclassified
concernForCommand
	| dict |
	dict := Dictionary new.
	self wValue ifNotNil: [:val |
		dict at: 'w' put: val].
	self jValue ifNotNil: [:val |
		dict at: 'j' put: val].
	self wtimeoutValue ifNotNil: [:val |
		dict at: 'wtimeout' put: val].
	^dict isEmpty
		ifTrue: [ nil ]
		ifFalse: [ dict ].