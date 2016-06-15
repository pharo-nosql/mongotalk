tests
testReplicaSetStepDown
	"Note: This assumes that Mongo default has no replication set."

	self shouldSignalNotRunningWithReplSet: [ mongo replicaSetStepDown: 10 seconds ].