examples
workspaceCode
	| server |
	
	"Start"
	server := MongoTestServer new
				port: 27092;
				yourself.
	server start; waitIsWrittable.
	[[ 	[| isMaster |
		isMaster := server mongoDo: [ :mongo | mongo isMaster ].
		Transcript cr; show: isMaster localTime; cr]
			on: Error do: [ :e | e traceCr ].
		1 second wait.
		] doWhileTrue: [ server isStarted ] ] fork.

	"Play"
	server sigstop. "pause"
	server sigcont. "unpause"

	"Stop"
	server ensureTerminated.