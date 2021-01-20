operations
initiateReplicaSet
	"Send a replSetInitiate command to configure the replica set. Before, servers are independent and don't know each other. Note: It's required that servers are started, as a precondition.
	
	See: https://docs.mongodb.com/v4.0/reference/replica-configuration"

	servers first mongoDo: [ :mongo |
		mongo admin replSetInitiate: {
			'_id' -> self replicaSetName.
			'protocolVersion' -> 1.
			'members' -> memberDescriptions asArray.
			'settings' -> settingsDictionary
		} asOrderedDictionary ]
