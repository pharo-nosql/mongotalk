reading
nextInt64
	| unsigned |
	unsigned := stream next + (stream next bitShift: 8) + (stream next bitShift: 16) + (stream next bitShift: 24) + (stream next bitShift: 32) + (stream next bitShift: 40) + (stream next bitShift: 48) + (stream next bitShift: 56).
	^unsigned <= ((2 raisedTo: 63) - 1)
		ifTrue: [unsigned]
		ifFalse: [((2 raisedTo: 64) - unsigned) negated]