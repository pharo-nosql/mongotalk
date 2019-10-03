private
refreshTopologyWith: newServerDescription

	topologyMutex critical: [
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
			self discoverUrlsFrom: newServerDescription isMaster replicaSetHosts.
			self discoverUrlsFrom: newServerDescription isMaster replicaSetPassives ].

		announcer announce: (MongoSDAMTopologyUpdate
			from: oldTopology
			to: topology).
	].