hooks
doWriteOnCollection: collection
	collection 
		commandInsert: (Dictionary new at: 'key1' put: 'value1'; yourself) 
		writeConcern: nil