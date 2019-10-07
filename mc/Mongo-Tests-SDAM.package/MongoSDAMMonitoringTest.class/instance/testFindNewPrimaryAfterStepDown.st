tests - monitoring
testFindNewPrimaryAfterStepDown

	| topology |
	client := self newClient.
	self startClientAndWait.

	"Server A is the primary."
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlA.

	"Step down server A and force Crisis state in client."
	MongoReplicationTestResources stepDownA: 10 seconds.
	
	"Server B is elected as primary (the only electable, since C has zero priority)"
	client heartbeatFrequency wait.
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlB.
