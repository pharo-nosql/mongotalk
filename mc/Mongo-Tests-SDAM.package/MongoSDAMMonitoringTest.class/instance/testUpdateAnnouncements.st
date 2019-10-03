tests - monitoring
testUpdateAnnouncements
	
	| serverUpdates topologyUpdates |
	client := self newClient.

	"Set a tiny (unreal) value for heatbeat since default is too long for testing."
	client heartbeatFrequency: 100 milliSeconds.

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
	1 to: 3 do: [ :each |
		self assert: client topology servers size equals: 3.
		self assert: serverUpdates size equals: each * 3.
		self assert: topologyUpdates size equals: each * 3.
		client heartbeatFrequency wait.
	]