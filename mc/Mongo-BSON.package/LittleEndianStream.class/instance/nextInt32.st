reading
nextInt32
	| unsigned |
	unsigned := self nextUInt32.
	^unsigned <= ((2 raisedTo: 31) - 1)
		ifTrue: [unsigned]
		ifFalse: [((2 raisedTo: 32) - unsigned) negated]