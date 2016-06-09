utilities
encodeAndDecode: anObject	
	"Only works with objects for which #= works"
	| actual decode data |
	data := (Dictionary new)
				at: 'k' put: anObject;
				yourself.
	actual := BSON write: data.
	decode := BSON read: actual readStream.
	self
		assert: (decode at: 'k') = anObject