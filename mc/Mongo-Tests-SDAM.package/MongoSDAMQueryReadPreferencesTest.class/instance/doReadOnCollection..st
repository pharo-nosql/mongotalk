hooks
doReadOnCollection: collection
	^ collection
		select: { 'key1' -> 'value1' } asDictionary
		limit: 0
		offset: 0
		order: Dictionary new
		flags: QueryOperation flagSlaveOk