start/stop
ensureTerminated
	(osProcess notNil and: [ osProcess isRunning ])
		ifTrue: [ osProcess terminate ].
	osProcess := nil.

	(process notNil and: [ process isTerminated not ])
		ifTrue: [ process terminate ].
	process := nil.