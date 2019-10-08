stop/continue
waitTestingScenario
	Transcript << '#waitTestingScenario'.

	replicaSet
		ifNil: [ self start ]
		ifNotNil: [ self continueAllServers ].
		
	Transcript << '. C:'.
	self
		waitMongoAt: self mongoUrlC
		satisfies: [ :mongo | mongo isMaster isSecondary and: [ mongo isMaster isPassive ]  ]
		upTo: 15 seconds
		onCompletion: [ Transcript << 'OK' ]
		onTimeout: [ self error: 'C: TIMEOUT' ].

	Transcript << '. B:'.
	self
		waitMongoAt: self mongoUrlB
		satisfies: [ :mongo | mongo isMaster isSecondary ]
		upTo: 15 seconds
		onCompletion: [ Transcript << 'OK' ]
		onTimeout: [  self error: 'B: TIMEOUT' ].

	Transcript << '. A:'.
	self
		waitMongoAt: self mongoUrlA
		satisfies: [ :mongo | mongo isMaster isPrimary ]
		upTo: 25 seconds
		onCompletion: [ Transcript << 'OK' ]
		onTimeout: [  self error: 'A: TIMEOUT' ].
	Transcript cr.

	"Ensure there is no test database remaining from previous tests."
	(replicaSet serverAtUrl: self mongoUrlA) mongoDo: [ :mongo |
		(mongo databaseNames includes: self databaseName) ifTrue: [ 
			(mongo databaseNamed: self databaseName) drop ] ].
