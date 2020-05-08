running
stopAllExceptC
	"Stop possible primaries (and don't wait until client realizes of it)."

	MongoReplicationTestResources
		signalStopA;
		signalStopB.
