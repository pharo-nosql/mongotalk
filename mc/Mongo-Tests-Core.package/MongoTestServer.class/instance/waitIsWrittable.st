operations
waitIsWrittable
	| deadline |
	deadline := DateAndTime now + self timeout.
	
	[	osProcess isComplete ifTrue: [ 
			^ self error: ('Unexpected termination of mongod OS process: ', osProcess asString) ].
		[ self mongoDo: [ :mongo | ^ mongo isMaster ] ] 
			on: NetworkError
			do: [ 50 milliSeconds wait ].
	] doWhileTrue: [ DateAndTime now < deadline ].

	self error: ('Timeout waiting that {1} becomes writtable' format: { self fullHost })