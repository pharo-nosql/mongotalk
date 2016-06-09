reading
nextString: aNumber
	| string  |
	string := (stream next: (aNumber - 1)) asString.
	stream skip: 1.
	^GratuitousIncompatibilities utf8Codec decode: string.