operations
startAllAndInitiate
	servers := members collect: [ :dict |
		MongoTestServer new
			port: (dict at: #host) asMongoUrl port;
			replicaSetName: self replicaSetName;
			yourself ].
	servers do: [ :each | each start ].

	"Wait they are ready as standalone servers."	
	servers do: [ :each | each waitIsWrittable ].

	"Configure RS"
	self initiate.
