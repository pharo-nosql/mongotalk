tests
testReplicaSetStepDown

	"See _manual_set_up_ to set up the testing mongodb replica set."
	isMongoAvailable ifFalse: [ ^self skip ].

	mongo replicaSetStepDown: 10 seconds.

	self assert: mongo isOpen.
	
	[ 	self addNewCollection.
		self fail: 'should raise a `not master` error' ]
			on: MongoCommandError
			do: [ :error | 
				self assert: error isNotMaster ].
			
	20 seconds wait.
	
	self addNewCollection. "It should be primary again"