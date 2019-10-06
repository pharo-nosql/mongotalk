operations
initiate
	servers first mongoDo: [ :mongo |
		mongo admin replSetInitiate: {
			'_id' -> self replicaSetName.
			'protocolVersion' -> 1.
			'members' -> members asArray
		} asOrderedDictionary ]
