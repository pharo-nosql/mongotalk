tests
testOperationReadPreferenceNearest
	| servers minLatency nearestServerUrls |
	self startClientAndWait.
	self writeAndReadFromA.
	servers := client topology servers.

	self flag: #todo. "roundtrip may be 0 with local servers so should simulate latency. Then next assert must pass."
"	self
		assert: (servers collect: #roundtripDurationAverage as: Set) size
		equals: 3."

	minLatency := (servers collect: #roundtripDurationAverage) min.
	nearestServerUrls := servers
		select: [:each | each roundtripDurationAverage = minLatency ]
		thenCollect: #urlString.
	client
		mongoDo: [ :mongo |
			self assert: (nearestServerUrls includes: mongo urlString).
			self doReadOnMongo: mongo ]
		readPreference: MongoReadPreference newNearest
		localThreshold: 0 milliseconds
