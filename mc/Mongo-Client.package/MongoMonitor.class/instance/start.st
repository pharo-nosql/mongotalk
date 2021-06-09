accessing
start
	process ifNotNil: [ self error: 'already started' ].

	process := [
		| thisProcess |
		thisProcess := Processor activeProcess.
		[ self doMonitor ] doWhileTrue: [ process == thisProcess ].
		self stop.
	] forkAt: Processor userInterruptPriority named: self forkName