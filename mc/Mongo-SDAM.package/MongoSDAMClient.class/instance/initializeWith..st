initialization
initializeWith: initialUrls
	| initialUrlStrings |
	self initialize.

	mutex := Mutex new.
	announcer := Announcer new.
	monitors := Dictionary new.
	topology := MongoSDAMTopology new.

	initialUrlStrings := initialUrls collect: [:each | each asMongoUrl asMongoUrlString ].
	self
		addMonitorsForAll: initialUrlStrings
		andDo: [].
