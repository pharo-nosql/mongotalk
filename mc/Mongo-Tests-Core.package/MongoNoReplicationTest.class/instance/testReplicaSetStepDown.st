tests
testReplicaSetStepDown
	"Note: This assumes that Mongo default has no replication set."

	"Command implemented in mongodb >= 3.0"
	mongo version logCr.
	(mongo version beginsWith: '3') ifFalse: [ ^self skip ].

	self shouldSignalNotRunningWithReplSet: [ mongo replicaSetStepDown: 10 seconds ].