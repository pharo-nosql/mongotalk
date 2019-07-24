hooks
doReadOnCollection: collection
	^ collection select: { 'key1' -> 'value1'} asDictionary