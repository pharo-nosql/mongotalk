tests
testReplicaSet
	"Note: This assumes that Mongo default has no replication set."

	"Behavior depends on mongodb verison"
	mongo majorVersion >= 3 
		ifTrue: [
			self shouldSignalNotRunningWithReplSet: [ mongo replicaSet ]]
		ifFalse: [
			self should: [ mongo replicaSet ] raise: MongoCommandError ]