public API
oneShotWriteToPrimary
	"Do a write operation (insert) to the database."
	
	^ client primaryMongoDo: [ :mongo |
		| database collection |
		Transcript show: 'writing - '; show: mongo urlString; cr.
		database := mongo databaseNamed: 'x'.
		collection := database collectionAt: 'y'.
		collection commandInsert: (Dictionary new at: 'z1' put: 'z2'; yourself) writeConcern: nil ]