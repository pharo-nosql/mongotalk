visiting
visitWhereCondition: aWhereCondition 
	^ Dictionary new
		at: aWhereCondition label
		put: aWhereCondition javascript;
		yourself