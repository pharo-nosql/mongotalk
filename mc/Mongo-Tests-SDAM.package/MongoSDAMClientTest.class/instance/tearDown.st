running
tearDown
	super tearDown.
	
	client ifNotNil: [ client stop ]