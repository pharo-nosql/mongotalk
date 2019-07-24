hooks
doReadOnCollection: collection
	^ (collection
			commandFind: (Dictionary new at: 'key1' put: 'value1'; yourself)
			readConcern: nil) documents