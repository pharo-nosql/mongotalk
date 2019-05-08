instance creation
tearDown
	super tearDown.
	
	client ifNotNil: [ client stop ]