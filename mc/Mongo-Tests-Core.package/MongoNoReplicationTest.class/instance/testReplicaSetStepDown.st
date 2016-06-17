tests
testReplicaSetStepDown
	"Note: This test case assumes that Mongo default has no replication set."

	mongo majorVersion >= 3 ifTrue: [
		self shouldSignalNotRunningWithReplSet: [ mongo replicaSetStepDown: 10 seconds ]]
