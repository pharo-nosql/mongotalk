running
writeAndReadFromA
	"Write and read from A (error if it's another server)"

	MongoReplicationTestResources waitTestingScenario.
	
	self doWrite.

	client mongoDo: [ :mongo | 
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlA.
		self doReadOnMongo: mongo ].
