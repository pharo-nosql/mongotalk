tests - monitoring
testUpdateAnnouncements
	
	| serverUpdates topologyUpdates |
	client := self newClient.

	serverUpdates := SharedQueue new.
	client announcer
		when: MongoSDAMServerDescriptionUpdate
		send: #nextPut:
		to: serverUpdates.

	topologyUpdates := SharedQueue new.
	client announcer
		when: MongoSDAMTopologyUpdate
		send: #nextPut:
		to: topologyUpdates.
		
	self startClientAndWait.

	"Each monitor check generates an update of both server and topology (with heartbeatFrequency)."
	(1 to: 3)
		do: [ :each |
			self assert: client topology servers size equals: 3.
			self assert: serverUpdates size >= each * 3.
			self assert: topologyUpdates size >= each * 3 ]
		separatedBy: [ client heartbeatFrequency wait ]
