examples
scriptCode
	| example |
	"Ensure the replica set scenario is ready to use."
	MongoReplicationTestResources waitTestingScenario.

	"Start client and see how read and write operations are logged
	regularly."
	example := MongoClientExample new. 
	example startClientAndLoopReadingAndWriting.

	"Freeze server A and see how client adapts to the new replica set
	topology: B will become primary."
	MongoReplicationTestResources signalStopA.

	"Freeze also server B and see how the client adapts to the 
	new replica set topology: there is no primary to write now,
	but read operations show succeed in C."
	MongoReplicationTestResources signalStopB.

	"Unfreeze A and B and the client should return to initial state."
	MongoReplicationTestResources continueAllServers.

	"Something similar should happen if you stepDown servers (check
	the Mongo>>replicaSetStepDown: for more details on this operation."
	MongoReplicationTestResources stepDownA: 30 seconds.
	MongoReplicationTestResources stepDownB: 30 seconds.

	"Stop the example."
	example stopClient.
