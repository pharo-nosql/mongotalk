tests
shouldSignalNotRunningWithReplSet: aBlock

	aBlock
		on: MongoCommandError
		do: [ :error | 
			self assert: error isNotRunningWithReplSet.
			^ self ].
	self fail: 'mongodb should signal `not running with --replSet`'