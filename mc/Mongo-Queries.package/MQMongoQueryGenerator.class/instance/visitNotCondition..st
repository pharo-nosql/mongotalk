visiting
visitNotCondition: aCondition 
	^ Dictionary new
		at: (self visit: aCondition condition left)
		put: (Dictionary new
			at: aCondition label
			put: (self visit: aCondition condition right);
			yourself);
		yourself