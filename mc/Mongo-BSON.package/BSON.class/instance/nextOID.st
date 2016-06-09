reading
nextOID
	"read ObjectId from stream. ObjectId is encoded big-endian"
	| value |
	value := LargePositiveInteger basicNew: 12.
	12 timesRepeat: [
		value := (value bitShift: 8) bitOr: stream nextByte ].
	^OID value: (GratuitousIncompatibilities compressLargeInteger: value)