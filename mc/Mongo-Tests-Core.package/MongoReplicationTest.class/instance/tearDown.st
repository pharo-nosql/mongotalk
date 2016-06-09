running
tearDown
	super tearDown.
	mongo isOpen ifTrue: [mongo close].