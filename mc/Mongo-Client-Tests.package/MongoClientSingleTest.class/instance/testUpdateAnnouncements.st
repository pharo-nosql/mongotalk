tests - monitoring
testUpdateAnnouncements
	
	| serverUpdates topologyUpdates heartbeatSucceeded heartbeatStarted numberOfServers |
	client := self newClient.
	numberOfServers := 1.

	heartbeatStarted := SharedQueue new.
	client announcer
		when: MongoHeartbeatStarted
		send: #nextPut:
		to: heartbeatStarted.

	heartbeatSucceeded := SharedQueue new.
	client announcer
		when: MongoHeartbeatSucceeded
		send: #nextPut:
		to: heartbeatSucceeded.

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

	(1 to: 4)
		do: [ :each |
			self assert: client topology servers size equals: numberOfServers.
			self assert: heartbeatStarted size >= (each * numberOfServers).
			self assert: heartbeatSucceeded size >= (each * numberOfServers).
			self assert: serverUpdates size equals: numberOfServers.
			self assert: topologyUpdates size equals: 1 ]
		separatedBy: [ client settings heartbeatFrequency wait ]
