examples
workspaceCode
	| server |
	server := MongoTestServer new
				port: 27092;
				yourself.
	server start; waitIsWrittable.

	[[ 	[| isMaster |
		isMaster := server mongoDo: [ :mongo | mongo isMaster ].
		Transcript cr; show: isMaster localTime; cr]
			on: Error do: [ :e | e logCr ].
		1 second wait.
		] doWhileTrue: [ server isStarted ] ] fork.

	server sigstop. "pause server"
	server sigcont. "unpause it"
	server ensureTerminated. "finish server process"