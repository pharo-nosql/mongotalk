tests
testTwoPair
	| actual decode data |
	data := (Dictionary new)
				at: 'k' put: 'v';
				at: 'l' put: 'w';
				yourself.
	actual := BSON write: data.
	decode := BSON read: actual readStream.
	self
		assert: decode associations asArray = data associations asArray