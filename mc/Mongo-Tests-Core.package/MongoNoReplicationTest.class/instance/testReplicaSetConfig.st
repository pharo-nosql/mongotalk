tests
testReplicaSetConfig
	"Note: This assumes that Mongo default has no replication set."

	"Behavior depends on mongodb verison"
	mongo majorVersion >= 3 
		ifTrue: [
			self shouldSignalNotRunningWithReplSet: [ mongo replicaSetConfig ]]
		ifFalse: [
			self should: [ mongo replicaSetConfig ] raise: MongoCommandError ]