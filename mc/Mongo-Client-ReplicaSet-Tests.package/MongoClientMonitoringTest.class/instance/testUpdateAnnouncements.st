tests
testUpdateAnnouncements
	
	| serverUpdates topologyUpdates heartbeatSucceeded heartbeatStarted |
	client := self newClient.

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
			self assert: client topology servers size equals: 3.
			self assert: heartbeatStarted size >= (each * 3).
			self assert: heartbeatSucceeded size >= (each * 3).
			self assert: serverUpdates size >= 3.
			self assert: topologyUpdates size >= 1 ]
		separatedBy: [ client settings heartbeatFrequency wait ]
