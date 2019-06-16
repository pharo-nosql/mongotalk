tests - monitoring
testStepDown

	| topology |
	self timeLimit: 60 seconds.
	
	client := MongoSDAMClient withUrls: {
		MongoReplicationTestResources mongoUrlA.
		MongoReplicationTestResources mongoUrlB }.

	"Start monitoring and wait a bit until reaching Steady state."
	client steadyStateFrequency: 3 seconds.
	client start.
	100 milliSeconds wait.
	
	"Server A is the primary."
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlA.

	"Step down server A and force Crisis state in client."
	MongoReplicationTestResources stepDownA: 10 seconds.
	client stop; start.
	
	"There is no primary (election process going on)"
	1 second wait.
	topology := client topology.
	self deny: topology hasWritableServer.
	self assert: topology isTypeReplicaSetNoPrimary.

	"Server B is elected as primary (the only electable, since C has zero priority)"
	5 seconds wait.
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlB.

	"Now, wait a bit and then check A is up again and the new primary (it has higher priority than B)."
	16 seconds wait.
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlA.
