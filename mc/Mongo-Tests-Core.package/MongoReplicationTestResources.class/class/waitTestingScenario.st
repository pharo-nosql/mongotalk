stop/continue
waitTestingScenario

	| retryingDelay end |
	Transcript << '#waitTestingScenario '.

	retryingDelay := 500 milliSeconds.
	end := DateAndTime now + 40 seconds.

	self ensureStarted.

	[	[	self assert: ((replicaSet
				serverAtUrl: self mongoUrlA)
				mongoDo: [ :mongo | mongo isMaster isPrimary ]).

			self assert: ((replicaSet
				serverAtUrl: self mongoUrlB)
				mongoDo: [ :mongo | mongo isMaster isSecondary ]).

			self assert: ((replicaSet
				serverAtUrl: self mongoUrlC)
				mongoDo: [ :mongo | mongo isMaster isSecondary and: [ mongo isMaster isPassive ] ]).

			"Ensure there is no test database remaining from previous tests."
			(replicaSet serverAtUrl: self mongoUrlA) mongoDo: [ :mongo |
				(mongo databaseNames includes: self databaseName) ifTrue: [ 
					(mongo databaseNamed: self databaseName) drop ] ].		

			^ Transcript << 'READY'; cr.

		] on: Error do: [ :e | Transcript << '.' ].
				
		retryingDelay wait.

	] doWhileFalse: [ DateAndTime now > end ].

	self error: 'TIMEOUT'.
