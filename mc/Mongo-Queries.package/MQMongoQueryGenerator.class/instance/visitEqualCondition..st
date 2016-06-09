visiting
visitEqualCondition: aCondition
	^ Dictionary new 
		at: (self visit: aCondition left) 
		put: (self visit: aCondition right);
		yourself