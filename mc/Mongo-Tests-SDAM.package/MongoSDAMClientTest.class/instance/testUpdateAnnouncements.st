tests - monitoring
testUpdateAnnouncements
	
	| serverUpdates topologyUpdates |
	client := MongoSDAMClient withUrls: { MongoReplicationTestResources mongoUrlA }.

	serverUpdates := SharedQueue new.
	client topologyUpdateAnnouncer
		when: MongoSDAMServerDescriptionUpdate
		send: #nextPut:
		to: serverUpdates.

	topologyUpdates := SharedQueue new.
	client topologyUpdateAnnouncer
		when: MongoSDAMTopologyUpdate
		send: #nextPut:
		to: topologyUpdates.
		
	client steadyStateFrequency: 200 milliSeconds.
	client start.

	"Wait the initial discovery of the 2 servers of the test replica set."
	50 milliSeconds wait.

	"Each monitor check generates an update of both server and topology (with steadyStateFrequency)."
	1 to: 3 do: [ :each |
		self assert: client topology servers size equals: 2.
		self assert: serverUpdates size equals: each * 2.
		self assert: topologyUpdates size equals: each * 2.
		client steadyStateFrequency wait.
	]