initialization
initializeWith: initialUrls
	self initialize.

	mutex := Mutex new.
	topologyUpdateAnnouncer := Announcer new.
	monitors := #().	
	topology := MongoSDAMTopology new.

	self addMonitorsForAll: (initialUrls collect: [:each |
		self canonicalMongoUrlAsString: each ]).
