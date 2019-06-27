tests - read preference
testGlobalReadPreferencePrimary

	| selected topology |
	self timeLimit: 5 seconds.
	
	client := MongoSDAMClient withUrls: {
		MongoReplicationTestResources mongoUrlA }.

	client readPreference: MongoReadPreference primary.

	"Start monitoring and wait a bit until reaching Steady state."
	client steadyStateFrequency: 3 seconds.
	client start.
	100 milliSeconds wait.

	"Server A is the primary."
	topology := client topology.
	self assert: topology hasWritableServer.
	self assert: topology isTypeReplicaSetWithPrimary.
	self assert: topology primaryUrl equals: MongoReplicationTestResources mongoUrlA.

	"It writes to primary (A)"
	client mongoDo: [ :mongo |
		| database collection |
		database := mongo databaseNamed: self databaseNameForTesting.
		collection := database addCollection: self collectionNameForTesting.
		collection add: (Dictionary new at: 'key1' put: 'value1'; yourself).
		].

	"It reads from primary (A)"
	client mongoDo: [ :mongo |
		| database collection |
		database := mongo databaseNamed: self databaseNameForTesting.
		collection := database collectionAt: self collectionNameForTesting.
		selected := collection select: { 'key1' -> 'value1'} asDictionary ].
	self assert: selected size equals: 1.

	"Step down server A and force Crisis state in client."
	MongoReplicationTestResources stepDownA: 10 seconds.
	client restart.
	1 second wait.
	
	"It can't read from the secondary (B)"
	self
		should: [ 
			client mongoDo: [ :mongo |
				| database collection |
				database := mongo databaseNamed: self databaseNameForTesting.
				collection := database collectionAt: self collectionNameForTesting.
				selected := collection select: { 'key1' -> 'value1'} asDictionary ] ]
		raise: MongoQueryError
