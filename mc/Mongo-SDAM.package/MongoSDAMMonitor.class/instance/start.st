accessing
start
	process ifNotNil: [ self error: 'already started' ].

	process := [
		| thisProcess |
		thisProcess := Processor activeProcess.
		[ self doMonitor ] doWhileTrue: [ process == thisProcess ] ] forkNamed: 'Monitoring ', urlString.