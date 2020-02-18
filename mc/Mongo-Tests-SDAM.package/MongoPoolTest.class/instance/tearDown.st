running
tearDown
	database ifNotNil: [ database collections do: #drop ].
	pool return: root.
	pool closeAll.