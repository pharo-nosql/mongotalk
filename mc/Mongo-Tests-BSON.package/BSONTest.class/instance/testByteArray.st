tests
testByteArray
	| actual decode data |
	data := (Dictionary new)
				at: 'k' put: #[23 44 12 2 23 55 32 1 23 54 5 32];
				yourself.
	actual := BSON write: data.
	decode := BSON read: actual readStream.
	self
		assert: decode associations asArray = data associations asArray