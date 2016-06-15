tests
testReplicaSetStepDown

	"Follow my class comment to set up the expected mongodb replica set."
	isMongoAvailable ifFalse: [ ^self skip ].

	mongo replicaSetStepDown: 10 seconds.

	self assert: mongo isOpen.
	
	[ 	self addNewCollection.
		self fail: 'should raise a `not master` error' ]
			on: MongoCommandError
			do: [ :error | 
				self assert: error isNotMaster ].
			
	15 seconds wait.
	
	self addNewCollection. "It should be primary again"