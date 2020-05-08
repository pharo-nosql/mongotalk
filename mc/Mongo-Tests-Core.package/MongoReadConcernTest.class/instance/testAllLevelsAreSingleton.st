tests
testAllLevelsAreSingleton
	self allLevelStrings do: [ :level | 
		| twoAnswers |
		twoAnswers := (1 to: 2)
			collect: [ :each | MongoReadConcern perform: level ].
		self assert: twoAnswers asIdentitySet size equals: 1 ]