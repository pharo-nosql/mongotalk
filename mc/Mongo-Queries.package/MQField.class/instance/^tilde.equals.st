comparing
~= anObject
	^ MQNotEqualCondition new
		left: self;
		right: anObject;
		yourself