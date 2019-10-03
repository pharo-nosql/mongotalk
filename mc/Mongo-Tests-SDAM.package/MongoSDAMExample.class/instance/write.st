public API
write
	^ client
		mongoDo: [ :mongo |
			| database collection |
			Transcript show: 'writing - '; show: mongo urlString; cr.
			database := mongo databaseNamed: 'x'.
			collection := database collectionAt: 'y'.
			collection commandInsert: (Dictionary new at: 'z1' put: 'z2'; yourself) writeConcern: nil ]
		readPreference: MongoReadPreference newPrimary 
