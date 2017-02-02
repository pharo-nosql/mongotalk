comparing
matchesRegex: aRegExString
	^ MQRegexCondition new
		left: self;
		right: aRegExString;
		yourself