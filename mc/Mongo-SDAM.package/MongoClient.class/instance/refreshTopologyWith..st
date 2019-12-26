private
refreshTopologyWith: newServerDescription

	topologyMutex critical: [
		| latestServerDescription oldTopology |
		latestServerDescription := topology serverAt: newServerDescription urlString.
		announcer announce: (MongoServerDescriptionUpdate
			from: latestServerDescription
			to: newServerDescription).
		
		oldTopology := topology.
		topology := MongoTopology
			newBasedOn: topology
			updatedWith: newServerDescription.

		(newServerDescription isSuccess and: [ newServerDescription isMaster isReplicaSet ]) ifTrue: [ 
			self discoverUrlsFrom: newServerDescription isMaster replicaSetHosts.
			self discoverUrlsFrom: newServerDescription isMaster replicaSetPassives ].

		announcer announce: (MongoTopologyUpdate
			from: oldTopology
			to: topology).
	].