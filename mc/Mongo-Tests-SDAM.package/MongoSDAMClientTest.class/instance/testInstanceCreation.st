instance creation
testInstanceCreation
	"SDAM spec explicits that clients shouldn't try to connect on isntance creation."
	
	self
		should: [
			client := MongoSDAMClient
				withUrls: {MongoReplicationTestResources mongoUrlOffline} ]
		notTakeMoreThan: 1 milliSecond.

	self assert: client topology isTypeUnknown.
	self assert: client topology servers size equals: 1.
"	self assert: client topology servers anyOne isTypeUnknown."
