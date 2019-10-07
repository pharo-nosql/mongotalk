tests - discovering
testDiscoverAllFrom: aCollectionOfZnUrls
	
	client := MongoSDAMClient withUrls: aCollectionOfZnUrls.
	client start.

	"Doesn't know more than one (unknown) server."
	self deny: client topology servers anyOne isSuccess.
	self assert: client topology servers size equals: 1.

	"Assert it discovered all servers."
	10 milliSeconds wait.
	self assert: (client topology servers allSatisfy: #isSuccess).
	self
		assert: client topology servers size
		equals: MongoReplicationTestResources allMongoUrls size.
