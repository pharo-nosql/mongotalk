instance creation
testDiscoverFromHidden
	
	client := MongoSDAMClient withUrls: {
		MongoReplicationTestResources mongoUrlC }.

	client start.

	"Impossible to know it already, but there is one (unknown) server."
	self assert: client topology isTypeUnknown.
	self assert: client topology servers size equals: 1.

	10 milliSeconds wait.
	self assert: client topology servers size equals: 3.
