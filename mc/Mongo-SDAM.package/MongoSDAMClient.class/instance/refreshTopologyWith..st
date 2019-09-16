private
refreshTopologyWith: newServerDescription

	mutex critical: [
		| latestServerDescription oldTopology |
		latestServerDescription := topology serverAt: newServerDescription urlString.
		announcer announce: (MongoSDAMServerDescriptionUpdate
			from: latestServerDescription
			to: newServerDescription).
		
		oldTopology := topology.
		topology := MongoSDAMTopology
			newBasedOn: topology
			updatedWith: newServerDescription.

		newServerDescription isSuccess ifTrue: [ 
			self discoverUrlsFrom: newServerDescription isMaster replicaSetHosts ].

		announcer announce: (MongoSDAMTopologyUpdate
			from: oldTopology
			to: topology).
	].