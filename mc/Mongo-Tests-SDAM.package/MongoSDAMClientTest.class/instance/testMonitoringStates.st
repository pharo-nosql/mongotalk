tests - monitoring
testMonitoringStates

	| topology |
	self timeLimit: 60 seconds.

	client := MongoSDAMClient withUrls: {
		MongoReplicationTestResources mongoUrlA.
		MongoReplicationTestResources mongoUrlB }.

	client crisisStateFrequency: 0.5 seconds.
	client steadyStateFrequency: 2 seconds.

	"Start monitoring and wait a bit until reaching Steady state."
	client start.
	100 milliSeconds wait.
	
	"Server A is the primary."
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlA.

	"Step down server A and force Crisis state in client."
	MongoReplicationTestResources stepDownB: 1 second.
	MongoReplicationTestResources stepDownA: 10 seconds.
	client restart.
	
	"There is no primary"
	1 second wait.
	topology := client topology.
	self deny: topology hasWritableServer.
	self assert: topology isTypeReplicaSetNoPrimary.

	"Server B is elected as primary (the only electable, since C has zero priority)"
	6 seconds wait.
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlB.

	"Now, wait a bit and then check A is up again and the new primary (it has higher priority than B)."
	15 seconds wait.
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlA.
