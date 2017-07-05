operations
replicaSetConfig
	"Answer the configuration of the replica set.
	See more at: https://docs.mongodb.com/v3.2/reference/command/replSetGetConfig/"

	| reply |
	reply := self command: (OrderedIdentityDictionary new at: #replSetGetConfig put: 1; yourself).

	^MongoReplicaSetConfig with: reply