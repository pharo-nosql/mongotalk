stop/continue
waitTestingScenario

	| retryingDelay end |
	retryingDelay := 500 milliSeconds.
	end := DateAndTime now + 1 minute.

	self ensureStarted.

	[	[	self assert: ((replicaSet
				serverAtUrl: self mongoUrlA)
				mongoDo: [ :mongo | mongo isMaster isPrimary ]).

			self assert: ((replicaSet
				serverAtUrl: self mongoUrlB)
				mongoDo: [ :mongo |
					| response |
					response := mongo isMaster.
					response isSecondary and: [ response staleness < 10 seconds ] ]).

			self assert: ((replicaSet
				serverAtUrl: self mongoUrlC)
				mongoDo: [ :mongo |
					| response |
					response := mongo isMaster.
					response isSecondary and: [ 
						response isPassive and: [ 
						response staleness < 10 seconds ] ]]).

			"Ensure there is no test database remaining from previous tests."
			(replicaSet serverAtUrl: self mongoUrlA) mongoDo: [ :mongo |
				(mongo databaseNames includes: self databaseName) ifTrue: [ 
					(mongo databaseNamed: self databaseName) drop ] ].		

			^ Transcript << 'READY'; cr.

		] on: Error do: [ :e | Transcript << '.' ].
				
		retryingDelay wait.

	] doWhileFalse: [ DateAndTime now > end ].

	self error: 'TIMEOUT'.
