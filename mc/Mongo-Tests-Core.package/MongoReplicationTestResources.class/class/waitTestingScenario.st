accessing
waitTestingScenario
	self
		signalContinueA;
		signalContinueB;
		signalContinueC.
		
	Transcript cr; << 'waitTestingScenario'.
	Transcript << '. C:'.
	self
		waitMongoAt: self mongoUrlC
		satisfies: [ :mongo | mongo isMaster isSecondary and: [ mongo isMaster isPassive ]  ]
		upTo: 15 seconds
		onCompletion: [ Transcript << 'OK' ]
		onTimeout: [ Transcript << 'TIMEOUT' ].

	Transcript << '. B:'.
	self
		waitMongoAt: self mongoUrlB
		satisfies: [ :mongo | mongo isMaster isSecondary ]
		upTo: 15 seconds
		onCompletion: [ Transcript << 'OK' ]
		onTimeout: [ Transcript << 'TIMEOUT' ].

	Transcript << '. A:'.
	self
		waitMongoAt: self mongoUrlA
		satisfies: [ :mongo |
			| isMasterResponse |
			isMasterResponse := mongo isMaster.
			(isMasterResponse hasPrimary
				and: [ isMasterResponse primaryUrlString = mongo urlString ])
				and: [ (mongo databaseNames includes: self databaseName) not 
					or: [ (mongo databaseNamed: self databaseName) drop. true ] ] ]
		upTo: 25 seconds
		onCompletion: [ Transcript << 'OK' ]
		onTimeout: [ Transcript << 'TIMEOUT' ].
	Transcript cr.