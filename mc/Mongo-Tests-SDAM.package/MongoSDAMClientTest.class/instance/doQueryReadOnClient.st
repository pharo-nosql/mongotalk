running
doQueryReadOnClient
	client mongoDo: [ :mongo |
		| database collection |
		database := mongo databaseNamed: self databaseNameForTesting.
		collection := database collectionAt: self collectionNameForTesting.
		^ collection select: { 'key1' -> 'value1'} asDictionary ]