instance creation
testDiscoverPrimary
	
	client := MongoSDAMClient withUrls: {
		MongoReplicationTestResources mongoUrlB }.

	client start.
	
	"Impossible to know it already, but there is one (unknown) server."
	self assert: client topology isTypeUnknown.
	self assert: client topology servers size equals: 1.
"	self assert: client topology servers anyOne isTypeUnknown."

	"After some ms, it's time."
	10 milliSeconds wait.
	self assert: client topology isTypeReplicaSetWithPrimary.
	self assert: client topology servers size equals: 2