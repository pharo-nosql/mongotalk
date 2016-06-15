tests
shouldSignalNotRunningWithReplSet: aBlock

	aBlock
		on: MongoCommandError
		do: [ :error | 
			"self assert: error isNotRunningWithReplSet. -> apparently in mongodb 2.6 it's not always true."
			^ self ].
	self fail: 'mongodb should signal `not running with --replSet`'