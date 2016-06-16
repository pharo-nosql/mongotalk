tests
testReplicaSetStepDown
	"Note: This assumes that Mongo default has no replication set."

	"Command implemented in mongodb >= 3.0"
	FileStream stdout << mongo version; cr; flush.
	(mongo version beginsWith: '3') ifFalse: [ 
		FileStream stdout << 'skip testReplicaSetStepDown'; cr; flush.
		^self skip ].
	FileStream stdout << 'do not skip testReplicaSetStepDown'; cr; flush.

	self shouldSignalNotRunningWithReplSet: [ mongo replicaSetStepDown: 10 seconds ].