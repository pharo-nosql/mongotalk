reading
nextSizedString
	| size result  |
	size := stream nextUInt32.
	^ stream nextString: size