tests
testPair
	| expected actual decode data |
	expected := #[14 0 0 0 2 107 0 2 0 0 0 118 0 0].
	data := (Dictionary new)
				at: 'k' put: 'v';
				yourself.
	actual := BSON write: data.
	self assert: expected = actual.
	decode := BSON read: actual readStream.
	self
		assert: decode associations asArray = data associations asArray