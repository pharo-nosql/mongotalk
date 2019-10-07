tests - monitoring
testRecoverInitialPrimaryAfterSIGCONT

	client := self newClient.
	self startClientAndWait.

	"Server A is the primary."
	self assert: client topology primaryUrl equals: MongoReplicationTestResources mongoUrlA.

	MongoReplicationTestResources signalStopA.
	self waitMonitorsHeartbeatAndTimeout.
	
	"Server B is elected as primary (the only electable, since C has zero priority)"
	self assert: client topology primaryUrl equals: MongoReplicationTestResources mongoUrlB.

	MongoReplicationTestResources continueAllServers.
	self waitMonitorsHeartbeatAndTimeout.

	"A is up again and the new primary (it has higher priority than B)."
	self assert: client topology primaryUrl equals: MongoReplicationTestResources mongoUrlA.
