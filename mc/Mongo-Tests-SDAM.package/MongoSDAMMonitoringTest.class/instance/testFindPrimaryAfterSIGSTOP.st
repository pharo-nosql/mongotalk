tests - monitoring
testFindPrimaryAfterSIGSTOP

	| topology |
	client := self newClient.
	self startClientAndWait.

	MongoReplicationTestResources signalStopA.
	self waitMonitorsHeartbeatAndTimeout.
	
	"Server B is elected as primary (the only electable, since C has zero priority)"
	topology := client topology.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlB.
