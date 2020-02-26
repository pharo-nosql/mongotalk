tests - monitoring
testUpdateAnnouncements
	
	| serverUpdates topologyUpdates |
	client := self newClient.

	serverUpdates := SharedQueue new.
	client announcer
		when: MongoServerDescriptionUpdate
		send: #nextPut:
		to: serverUpdates.

	topologyUpdates := SharedQueue new.
	client announcer
		when: MongoTopologyUpdate
		send: #nextPut:
		to: topologyUpdates.
		
	self startClientAndWait.

	"Each monitor check generates an update of both server and topology (with heartbeatFrequency)."
	(1 to: 3)
		do: [ :each |
			self assert: client topology servers size equals: 1.
			self assert: serverUpdates size >= each.
			self assert: topologyUpdates size >= each ]
		separatedBy: [ client settings heartbeatFrequency wait ]
