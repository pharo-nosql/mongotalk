tests - monitoring
testFindPrimaryAfterStepDown

	| topology |
	client := self newClient.
	self startClientAndWait.

	MongoReplicationTestResources stepDownA: 10 seconds.
	
	"Server B is elected as primary (the only electable, since C has zero priority)"
	client heartbeatFrequency wait.
	topology := client topology.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlB.
