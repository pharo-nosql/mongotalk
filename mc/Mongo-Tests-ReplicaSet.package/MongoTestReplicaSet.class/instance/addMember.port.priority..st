initialization
addMember: idNumber port: portNumber priority: priorityNumber
	"Specify a mongod that will be started on #start. All arguments must be numbers. Precondition: self is not started.
	
	See: https://docs.mongodb.com/v4.0/reference/replica-configuration/#members"
	
	memberDescriptions add: {
		 	'_id' -> idNumber.
			'host' -> ('localhost:', portNumber asString).
			'priority' -> priorityNumber
		} asOrderedDictionary.
		
	servers add: (MongoTestServer new
			port: portNumber;
			replicaSetName: replicaSetName;
			yourself)