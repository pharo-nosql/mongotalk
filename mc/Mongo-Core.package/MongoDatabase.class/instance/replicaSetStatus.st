operations
replicaSetStatus
	"Answer the status of the replica set. Only works on 'admin' collection.
	See more at: https://docs.mongodb.com/v3.2/reference/command/replSetGetStatus/"

	| reply |
	reply := self command: (OrderedIdentityDictionary new at: #replSetGetStatus put: 1; yourself).

	^MongoReplicaSetStatus with: reply