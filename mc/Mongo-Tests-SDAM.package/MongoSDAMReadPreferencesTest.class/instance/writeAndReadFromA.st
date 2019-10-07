running
writeAndReadFromA
	"Write and read on primary (A)"

	self doWriteOnClient.
	
	client mongoDo: [ :mongo | 
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlA.
		self doReadOnMongo: mongo ].
