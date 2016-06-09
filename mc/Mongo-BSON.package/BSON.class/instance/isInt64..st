testing
isInt64: anInteger
	^anInteger between: (2 raisedTo: 63) negated and: (2 raisedTo: 63) - 1