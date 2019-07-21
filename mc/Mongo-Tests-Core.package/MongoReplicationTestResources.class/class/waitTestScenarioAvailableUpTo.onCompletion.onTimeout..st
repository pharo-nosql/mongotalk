convenience
waitTestScenarioAvailableUpTo: aDuration onCompletion: successBlock onTimeout: failBlock
	^ self
		waitPrimaryUrlEquals: self mongoUrlA
		upTo: aDuration
		onCompletion: successBlock
		onTimeout: failBlock