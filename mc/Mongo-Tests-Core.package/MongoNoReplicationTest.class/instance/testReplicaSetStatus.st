tests
testReplicaSetStatus
	"Note: This assumes that Mongo default has no replication set."

	self should: [ mongo replicaSetStatus ] raise: MongoCommandError