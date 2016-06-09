testing
notIn: aCollection
	^ MQNotInCondition new
		left: self;
		right: aCollection;
		yourself