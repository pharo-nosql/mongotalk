tests
testInstanceCreation
	"MongoDB specs explicits that clients shouldn't try to connect on instance creation."
	
	| count |
	count := SocketStream allInstances size.
	self
		should: [
			client := MongoClient withUrls: {
				MongoReplicationTestResources mongoUrlOffline } ]
		notTakeMoreThan: 100 milliSeconds.

	self assert: SocketStream allInstances size equals: count.
	self assert: client topology isTypeUnknown.
	self assert: client topology servers size equals: 1.
