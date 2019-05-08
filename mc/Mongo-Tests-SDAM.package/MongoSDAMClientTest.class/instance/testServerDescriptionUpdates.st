instance creation
testServerDescriptionUpdates
	
	| updates |
	client := MongoSDAMClient withUrls: {
		MongoReplicationTestResources mongoUrlOffline.
		MongoReplicationTestResources mongoUrlA.
		MongoReplicationTestResources mongoUrlB. }.

	updates := SharedQueue new.
	client topologyUpdateAnnouncer
		when: MongoSDAMServerDescriptionUpdate
		send: #nextPut:
		to: updates.
		
	client start.

	5 timesRepeat: [
		10 milliSeconds wait.
		self assert: client topology servers size equals: 3 ]