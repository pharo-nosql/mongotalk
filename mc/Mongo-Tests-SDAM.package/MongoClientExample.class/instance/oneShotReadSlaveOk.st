public API
oneShotReadSlaveOk 
	^ client
		mongoDo: [ :mongo |
			| database collection |
			Transcript show: 'reading - '; show: mongo urlString; cr.
			database := mongo databaseNamed: 'x'.
			collection := database collectionAt: 'y'.
			(collection commandFind: Dictionary new limit: 0 readConcern: nil)
				setFlagSlaveOk;
				contents ]