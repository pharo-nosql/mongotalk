accessing
isTestScenarioAvailable
	"Detects whether the testing scenario is available (see _manual_set_up_)"
	
	^ isTestScenarioAvailable ifNil: [
		isTestScenarioAvailable := 
			[ self newMongoA open; close. true ] 
				on: NetworkError 
				do: [ 	false ]]