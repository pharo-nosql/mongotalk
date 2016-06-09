converting
readDoubleFrom: aStream
	| result |
	result := Float new: 2.
	result basicAt: 2 put: aStream nextUInt32.
	result basicAt: 1 put: aStream nextUInt32.
	^result