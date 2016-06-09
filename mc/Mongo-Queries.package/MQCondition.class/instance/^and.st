logical operation
& aCondition
	^ MQAndCondition 
		conditions: (Array with: self with: aCondition)