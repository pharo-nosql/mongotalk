start/stop
ensureTerminated
	(process notNil and: [ process isTerminated not ])
		ifTrue: [ process terminate ].
	process := nil.