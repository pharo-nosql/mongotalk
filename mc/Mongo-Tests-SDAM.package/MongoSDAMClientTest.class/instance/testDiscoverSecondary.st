instance creation
testDiscoverSecondary
	
	client := MongoSDAMClient withUrls: {
		MongoReplicationTestResources mongoUrlA }.

	client start.

	"Impossible to know it already, but there is one (unknown) server."
	self assert: client topology isTypeUnknown.
	self assert: client topology servers size equals: 1.

	5 timesRepeat: [
		10 milliSeconds wait.
		self assert: client topology servers size equals: 2 ]