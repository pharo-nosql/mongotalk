tests
testReusesDictionary
	| aReadConcern twoAnswers |
	aReadConcern := MongoReadConcern local.
	twoAnswers := (1 to: 2)
		collect: [ :each | aReadConcern concernForCommand ].
	self assert: twoAnswers asIdentitySet size equals: 1