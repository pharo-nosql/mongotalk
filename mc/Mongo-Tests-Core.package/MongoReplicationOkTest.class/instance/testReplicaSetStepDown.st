tests
testReplicaSetStepDown
	
	self timeLimit: 60 seconds.

	"Step down the (prioritary) primary during some seconds"
	mongo replicaSetStepDown: 10 seconds.

	"It's still connected but it's not primary."
	self assert: mongo isOpen.
	
	"Then, it will signal an error on a write operation."
	[ 	self addNewCollection.
		self fail: 'should raise a `not master` error' ]
			on: MongoCommandError
			do: [ :error | self assert: error isNotMaster ].

	"When the step down seconds passed, and the election finished, 
	the former primary server will be the primary again because it has more priority
	(see the replication scenario)."
	30 seconds wait.
	
	"It should be primary again, and complete the write operation without any error."
	self shouldnt: [ self addNewCollection ] raise: MongoCommandError.