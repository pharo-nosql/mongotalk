reading
nextString
	| string  |
	string := (stream upTo: 0) asString.
	^GratuitousIncompatibilities utf8Codec decode: string.