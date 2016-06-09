tests
testTimeStamp
	| actual decode data |
	data := Dictionary new
				at: 't' put: (MongoTimeStamp value: ((1412180887 << 32) bitOr: 3));
				yourself.
	actual := BSON write: data.
	decode := BSON read: actual readStream.
	self
		assert: decode associations asArray
		equals: data associations asArray