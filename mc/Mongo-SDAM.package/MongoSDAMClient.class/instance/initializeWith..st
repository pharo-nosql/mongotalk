initialization
initializeWith: initialUrls
	| initialUrlStrings |
	self initialize.

	readPreference := MongoReadPreference primary.
	serverSelectionTimeoutMS := 3000.

	mutex := Mutex new.
	announcer := Announcer new.
	monitors := Dictionary new.
	topology := MongoSDAMTopology new.

	initialUrlStrings := initialUrls collect: [:each |
		self canonicalMongoUrlAsString: each ].
	self
		addMonitorsForAll: initialUrlStrings
		andDo: [].
