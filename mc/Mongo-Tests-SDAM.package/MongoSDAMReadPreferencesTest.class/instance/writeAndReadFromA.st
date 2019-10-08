running
writeAndReadFromA
	"Write and read from A (error if it's another server)"

	self doWriteOnClient.

	client mongoDo: [ :mongo | 
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlA.
		self doReadOnMongo: mongo ].
