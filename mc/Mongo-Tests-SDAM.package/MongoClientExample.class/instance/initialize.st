initialization
initialize
	super initialize.
	
	client := self newClient.
	client announcer
		when: MongoTopologyUpdate
		send: #topologyUpdated:
		to: self