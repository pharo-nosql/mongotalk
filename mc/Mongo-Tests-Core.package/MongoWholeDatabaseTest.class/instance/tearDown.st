running
tearDown
	database ifNotNil: [ database drop ].
	root closeIfOpen