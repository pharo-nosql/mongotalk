tests
testEmbeddedDictionary
	| actual decode data subData |
	subData := Dictionary new
		at: 'sk' put: 'v';
		yourself.
	data := Dictionary new
		at: 'k' put: subData;
		yourself.
	actual := BSON write: data.
	decode := BSON read: actual readStream.
	self assert: decode size = 1.
	self assert: (decode at: 'k') size = 1.
	self assert: ((decode at: 'k') at: 'sk') = 'v'