tests - discovering
testDiscoverAllFrom: aCollectionOfZnUrls
	
	client := MongoSDAMClient withUrls: aCollectionOfZnUrls.
	client start.

	"Impossible to know it already, but there is one (unknown) server."
	self assert: client topology isTypeUnknown.
	self assert: client topology servers size equals: 1.

	"Assert it discovered all servers."
	10 milliSeconds wait.
	self
		assert: client topology servers size
		equals: MongoReplicationTestResources allMongoUrls size.
