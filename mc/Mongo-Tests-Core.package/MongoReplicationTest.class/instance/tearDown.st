running
tearDown
	super tearDown.
	mongo ifNotNil: [ mongo closeIfOpen ].