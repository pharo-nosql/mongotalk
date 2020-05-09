initialization
initializeWith: initialUrls
	| initialUrlStrings |
	self initialize.

	topologyMutex := Mutex new.
	monitors := Dictionary new.
	topology := MongoTopology new.
	settings := MongoClientSettings for: self.

	initialUrlStrings := initialUrls collect: [:each | each asMongoUrl asMongoUrlString ].
	self
		addMonitorsForAll: initialUrlStrings
		andDo: [].
