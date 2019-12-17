tests
testOperationReadPreferenceNearest
	| servers nearestServer |
	self startClientAndWait.
	self writeAndReadFromA.
	servers := client topology servers.

	self flag: #todo. "roundtrip may be 0 with local servers so should simulate latency. Then next assert must pass."
"	self
		assert: (servers collect: #roundtripDurationAverage as: Set) size
		equals: 3."

	nearestServer := servers detectMin: #roundtripDurationAverage.
	client
		mongoDo: [ :mongo |
			self assert: mongo urlString = nearestServer urlString.
			self doReadOnMongo: mongo ]
		readPreference: MongoReadPreference newNearest
		localThreshold: 0 milliseconds
