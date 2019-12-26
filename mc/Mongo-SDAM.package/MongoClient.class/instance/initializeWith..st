initialization
initializeWith: initialUrls
	| initialUrlStrings |
	self initialize.

	topologyMutex := Mutex new.
	announcer := Announcer new.
	monitors := Dictionary new.
	topology := MongoTopology new.

	initialUrlStrings := initialUrls collect: [:each | each asMongoUrl asMongoUrlString ].
	self
		addMonitorsForAll: initialUrlStrings
		andDo: [].
