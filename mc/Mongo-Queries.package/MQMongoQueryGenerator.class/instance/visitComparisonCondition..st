visiting
visitComparisonCondition: aCondition
	^ Dictionary new 
		at: (self visit: aCondition left) 
		put: (Dictionary new
			at: aCondition label
			put: (self visit: aCondition right);
			yourself);
		yourself