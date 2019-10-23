running
commandReadOn: collection
	^ (collection
			commandFind: (Dictionary new at: 'key1' put: 'value1'; yourself)
			readConcern: nil)
			setFlagSlaveOk;
			contents