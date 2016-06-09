comparing
<= anObject
	^ MQLessThanEqualCondition new
		left: self;
		right: anObject;
		yourself