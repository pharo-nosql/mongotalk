tests
testEmpty
	| expected actual decode data |
	expected := #[5 0 0 0 0].
	data := Dictionary new.
	actual := BSON write: data.
	self assert: expected = actual.
	decode := BSON read: actual readStream.
	self
		assert: decode associations asArray = data associations asArray