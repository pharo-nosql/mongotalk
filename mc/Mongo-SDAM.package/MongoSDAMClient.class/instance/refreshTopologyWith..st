monitoring
refreshTopologyWith: newServerDescription

	mutex critical: [
		| latestServerDescription newTopology |
		latestServerDescription := topology serverAt: newServerDescription urlString.
		topologyUpdateAnnouncer announce: (MongoSDAMServerDescriptionUpdate
			from: latestServerDescription
			to: newServerDescription).
		
		(topology hasAnythingNew: newServerDescription) ifTrue: [ 
			self discoverUrlsFrom: newServerDescription isMaster hosts ].

		newTopology := MongoSDAMTopology
			newBasedOn: topology
			updatedWith: newServerDescription.
		topologyUpdateAnnouncer announce: (MongoSDAMTopologyUpdate
			from: topology
			to: newTopology).
		topology := newTopology
	].