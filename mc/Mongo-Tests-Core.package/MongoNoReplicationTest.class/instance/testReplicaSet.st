tests
testReplicaSet
	"Note: This assumes that Mongo default has no replication set."

	self shouldSignalNotRunningWithReplSet: [ mongo replicaSet ]