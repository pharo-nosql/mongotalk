tests
testWideString
	| actual decode data |
	data := (Dictionary new)
				at: 'test' put: (String streamContents: [:stream| stream nextPutAll: 'nice test '; nextPut: (Character value: 128513)]);
				yourself.
	actual := BSON write: data.
	decode := BSON read: actual readStream.
	self
		assert: decode associations asArray = data associations asArray.