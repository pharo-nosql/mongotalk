stop/continue
shutDown: aboutToQuit
	aboutToQuit ifTrue: [ self stop ]