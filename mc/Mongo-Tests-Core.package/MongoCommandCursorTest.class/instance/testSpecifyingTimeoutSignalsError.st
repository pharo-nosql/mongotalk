tests
testSpecifyingTimeoutSignalsError
	| cursor |
	cursor := MongoCommandCursor
		database: database
		dictionary: self commandForTesting.
	cursor timeoutOrNil: 1000 milliSeconds.
	self
		should: [ cursor contents ]
		raise: MongoCommandError
		whoseDescriptionIncludes: 'cannot set maxTimeMS on getMore command for a non-awaitData cursor'
		description: 'This is the expected behavior in Mongo (4).'