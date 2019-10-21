tests - monitoring
testFindPrimaryAfterStepDown

	| topology |
	client := self newClient.
	self startClientAndWait.

	MongoReplicationTestResources stepDownA: 10 seconds.
	
	"Wait enough time (it should be enough to wait client's heartbeatFrequency)"
	8 seconds wait.

	"Server B is elected as primary (the only electable, since C has zero priority)"
	topology := client topology.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlB.
