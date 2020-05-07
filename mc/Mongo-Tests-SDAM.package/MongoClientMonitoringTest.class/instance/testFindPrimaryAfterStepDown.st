tests
testFindPrimaryAfterStepDown

	| topology |
	client := self newClient.
	self startClientAndWait.

	MongoReplicationTestResources stepDownA: 10 seconds.
	
	"Wait a bit (client's heartbeatFrequency should be enough)"
	9.5 seconds wait.

	"Server B is elected as primary (the only electable, since C has zero priority)"
	topology := client topology.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlB.
