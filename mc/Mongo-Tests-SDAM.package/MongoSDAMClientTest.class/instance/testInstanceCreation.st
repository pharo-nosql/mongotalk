tests - monitoring
testInstanceCreation
	"SDAM spec explicits that clients shouldn't try to connect on isntance creation."
	
	| count |
	count := SocketStream allInstances size.
	self
		should: [
			client := MongoSDAMClient withUrls: {
				MongoReplicationTestResources mongoUrlOffline } ]
		notTakeMoreThan: 1 milliSecond.

	self assert: SocketStream allInstances size equals: count.
	self assert: client topology isTypeUnknown.
	self assert: client topology servers size equals: 1.
