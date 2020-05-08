private
refreshTopologyWith: newServerDescription

	topologyMutex critical: [
		| latestServerDescription oldTopology |
		latestServerDescription := topology serverAt: newServerDescription urlString.
		
		"Announce a change in the server description"
		(self shouldAnnounce and: [ newServerDescription hasDifferenceWith: latestServerDescription ]) 
			ifTrue: [ announcer announce: 
				(MongoServerDescriptionUpdate
					from: latestServerDescription
					to: newServerDescription) ].

		"Update current topology"		
		oldTopology := topology.
		topology := MongoTopology
			newBasedOn: topology
			updatedWith: newServerDescription.

		"Try to discoover new hosts from isMaster"
		(newServerDescription isSuccess and: [ newServerDescription isMaster isReplicaSet ])
			ifTrue: [ 
				self discoverUrlsFrom: newServerDescription isMaster replicaSetHosts.
				self discoverUrlsFrom: newServerDescription isMaster replicaSetPassives ].

		"Announce a change in the topology"
		(self shouldAnnounce and: [ topology hasDifferenceWith: oldTopology ])
			ifTrue: [ announcer announce:
				(MongoTopologyUpdate from: oldTopology to: topology) ].
	].