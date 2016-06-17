running
tearDown
	super tearDown.
	(mongo isNotNil and: [mongo isOpen]) ifTrue: [mongo close].