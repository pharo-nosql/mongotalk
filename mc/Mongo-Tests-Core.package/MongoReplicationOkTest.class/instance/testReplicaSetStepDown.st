tests
testReplicaSetStepDown

	mongo replicaSetStepDown: 10 seconds.

	self assert: mongo isOpen.
	
	[ 	self addNewCollection.
		self fail: 'should raise a `not master` error' ]
			on: MongoCommandError
			do: [ :error | 
				self assert: error isNotMaster ].
			
	20 seconds wait.
	
	self addNewCollection. "It should be primary again"