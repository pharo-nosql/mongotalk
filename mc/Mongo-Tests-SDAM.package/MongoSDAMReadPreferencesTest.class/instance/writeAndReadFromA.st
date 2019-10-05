running
writeAndReadFromA
	"Write and read on primary (A)"

	self doWriteOnClient.
	
	self flag: #todo. "Improve this assert"
	client mongoDo: [ :mongo | 
		self
			assert: mongo urlString asMongoUrl
			equals: MongoReplicationTestResources mongoUrlA.
		self doReadOnMongo: mongo ].
