private
nextRequestID
	^requestID := requestID + 1 bitAnd: 16r3FFFFFFF