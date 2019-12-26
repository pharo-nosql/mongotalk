examples
workspaceCode
	| example |

	"Start"
	example := MongoExample new. 
	example start.
	MongoReplicationTestResources waitTestingScenario.

	"Play with mongod servers"
	MongoReplicationTestResources signalStopA.
	MongoReplicationTestResources signalStopB.
	MongoReplicationTestResources continueAllServers.
	MongoReplicationTestResources stepDownA: 30 seconds.
	MongoReplicationTestResources stepDownB: 30 seconds.

	"Stop"
	example stop.
