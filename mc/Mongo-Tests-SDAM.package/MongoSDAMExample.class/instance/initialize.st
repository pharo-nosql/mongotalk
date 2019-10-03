initialization
initialize
	super initialize.
	
	client := self newClient.
	client announcer
		when: MongoSDAMTopologyUpdate
		send: #topologyUpdated:
		to: self