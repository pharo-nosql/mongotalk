reading
nextDictionary
	| result byteSize start end |
	result := Dictionary new.
	byteSize := stream nextUInt32.
	[| type |
	type := stream nextByte.
	type = 0 ifTrue: [^result].
	self addObjectType: type to: result]
		repeat.
	^BSONError signal: 'Attempt to read off end of stream'