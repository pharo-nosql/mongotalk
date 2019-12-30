start/stop
ensureTerminated
	(osProcess notNil and: [ osProcess isRunning ])
		ifTrue: [ osProcess terminate ].
	osProcess := nil.
