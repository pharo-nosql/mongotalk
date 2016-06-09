tests
testReplicaSet
	"Note: This assumes that Mongo default has no replication set."

	self should: [ mongo replicaSet ] raise: MongoCommandError