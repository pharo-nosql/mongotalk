tests
testMultiple
	| actual data reader t f |
	data := Array with: ((Dictionary new)
						at: 't' put: true;
						yourself)
				with: ((Dictionary new)
						at: 'f' put: false;
						yourself).
	actual := BSON writeAll: data.
	reader := actual readStream.
	t := BSON read: reader.
	self assert: (t at: 't').
	f := BSON read: reader.
	self deny: (f at: 'f')