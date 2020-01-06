operations
waitIsWrittable
	| timeout retryDelay |
	timeout := DateAndTime now + self timeout.
	retryDelay := 250 milliSeconds.
	
	[ 	[ self mongoDo: [ :mongo | ^ mongo isMaster ] ] 
			on: Error
			do: [ Transcript << '.' ].
		retryDelay wait.
	] doWhileTrue: [ DateAndTime now < timeout ].

	self error: 'timeout'.