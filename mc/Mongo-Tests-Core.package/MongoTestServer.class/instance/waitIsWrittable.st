operations
waitIsWrittable
	| deadline retryDelay |
	deadline := DateAndTime now + self timeout.
	retryDelay := 250 milliSeconds asDelay.
	
	[ 	[ self mongoDo: [ :mongo | ^ mongo isMaster ] ] 
			on: Error
			do: [ Transcript << '.' ].
		retryDelay wait.
	] doWhileTrue: [ DateAndTime now < deadline ].

	self error: 'timeout'.