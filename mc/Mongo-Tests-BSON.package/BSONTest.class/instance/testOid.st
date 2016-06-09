tests
testOid
	| actual decode data |
	data := (Dictionary new)
				at: 'k' put: (OID value: (2 raisedTo: 95));
				yourself.
	actual := BSON write: data.
	decode := BSON read: actual readStream.
	self
		assert: decode associations asArray = data associations asArray