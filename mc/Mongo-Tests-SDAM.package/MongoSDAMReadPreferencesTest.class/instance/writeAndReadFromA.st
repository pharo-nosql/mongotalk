running
writeAndReadFromA
	"Write and read on primary (A)"

	self assert: client topology isTypeReplicaSetWithPrimary.
	self
		assert: client topology primaryUrl
		equals: MongoReplicationTestResources mongoUrlA.
	self
		doWriteOnClient;
		doReadOnClient