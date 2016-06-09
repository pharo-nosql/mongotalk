visiting
visitLogicalCondition: aLogicalCondition
	^ Dictionary new
		at: aLogicalCondition label
		put: (aLogicalCondition conditions collect: [ :each |
			self visit: each ]);
		yourself