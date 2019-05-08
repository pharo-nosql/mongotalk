monitoring
refreshTopologyWith: newServerDescription

	| latestServerDescription |
	latestServerDescription := topology serverAt: newServerDescription urlString.
	topologyUpdateAnnouncer announce: (MongoSDAMServerDescriptionUpdate
		from: latestServerDescription
		to: newServerDescription).
	
	(topology hasAnythingNew: newServerDescription) ifTrue: [ 
		| newTopology |
		self discoverUrlsFrom: newServerDescription ismaster hosts.
		newTopology := MongoSDAMTopology
			newBasedOn: topology
			updatedWith: newServerDescription ismaster.
		topologyUpdateAnnouncer announce: (MongoSDAMTopologyUpdate
			from: topology
			to: newTopology).
		topology := newTopology ].
