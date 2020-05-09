evaluating
add: aNumber
	previous := previous
		ifNil: [ aNumber ]
		ifNotNil: [ (0.8 * previous) + (0.2 * aNumber) ]