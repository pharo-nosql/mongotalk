public API
read 
	^ client
		mongoDo: [ :mongo |
			| database collection |
			Transcript show: 'reading - '; show: mongo urlString; cr.
			database := mongo databaseNamed: 'x'.
			collection := database collectionAt: 'y'.
			(collection commandFind: Dictionary new readConcern: nil)
				setFlagSlaveOk;
				contents ]