tests
testDate
	| expected actual decode data |
	expected := #[16 0 0 0 9 107 0 0 0 0 0 0 0 0 0 0].
	data := (Dictionary new)
				at: 'k' put: (GratuitousIncompatibilities newYear: 1970 day: 1);
				yourself.
	actual := BSON write: data.
	self assert: expected = actual.
	decode := BSON read: actual readStream.
	self
		assert: decode associations asArray = data associations asArray