running
tearDown
	database ifNotNil: [ database collections do: #drop ].
	root closeIfOpen