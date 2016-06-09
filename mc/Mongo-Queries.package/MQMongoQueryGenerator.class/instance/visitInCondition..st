visiting
visitInCondition: aCondition
	^ Dictionary new
		at: aCondition label
		put: (Dictionary new
			at: (self visit: aCondition left) 
			put: (self visit: aCondition right);
			yourself);
		yourself