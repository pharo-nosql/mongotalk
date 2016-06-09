logical operation
| aCondition
	^ MQOrCondition 
		conditions: (Array with: self with: aCondition)