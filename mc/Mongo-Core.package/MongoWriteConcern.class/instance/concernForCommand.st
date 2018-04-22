converting
concernForCommand
	| dict |
	dict := Dictionary new.
	self asKeysAndValuesInto: dict.
	^dict isEmpty
		ifTrue: [ nil ]
		ifFalse: [ dict ]