comparing
>= anObject
	^ MQGreaterThanEqualCondition new
		left: self;
		right: anObject;
		yourself