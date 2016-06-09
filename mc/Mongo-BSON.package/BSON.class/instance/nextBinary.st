reading
nextBinary
	| size  subType |
	size := stream nextUInt32.
	subType := stream nextByte. "sub type byte"
	"current spec states subType = 3 as old and the actual subType as 4. We handle both
	so a conversion is easier"
	(subType == 3) | (subType == 4) ifTrue: [ ^ self nextUUID: (stream nextBytes: size) ].
	^ stream nextBytes: size 