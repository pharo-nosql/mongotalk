running
commandReadOn: collection
	^ (collection
			commandFind: (Dictionary new at: 'key1' put: 'value1'; yourself)
			limit: 0
			readConcern: nil)
			setFlagSlaveOk;
			contents