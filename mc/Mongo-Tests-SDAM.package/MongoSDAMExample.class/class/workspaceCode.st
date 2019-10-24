examples
workspaceCode
	| example |

	"Start"
	example := MongoSDAMExample new. 
	example start.
	MongoReplicationTestResources waitTestingScenario.
	Transcript open; clear.

	"Play with mongod servers"
	MongoReplicationTestResources signalStopA.
	MongoReplicationTestResources signalStopB.
	MongoReplicationTestResources continueAllServers.
	MongoReplicationTestResources stepDownA: 30 seconds.
	MongoReplicationTestResources stepDownB: 30 seconds.

	"Stop"
	example stop.
