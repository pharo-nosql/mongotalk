tests - read preference
testGlobalReadPreferencePrimaryPreferredCommand

	| selected topology |
	self timeLimit: 30 seconds.
	
	client := MongoSDAMClient withUrls: {
		MongoReplicationTestResources mongoUrlA }.

	client readPreference: MongoReadPreference primaryPreferred.

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
	self doCommandWriteOnClient.

	"It reads from primary (A)"
	selected := self doCommandReadOnClient.
	self assert: selected size equals: 1.


	"Step down server A and force Crisis state in client."
	MongoReplicationTestResources stepDownA: 10 seconds.
	1 second wait.
	client restart.
	1 second wait.
	
	"It reads from secondary (B)"
	selected := nil.
	selected := self doCommandReadOnClient.
	self deny: selected isNil.
	self assert: selected size equals: 1.
