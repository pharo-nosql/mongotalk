running
tearDown
	collection drop.
	
	root admin
		command:
			(OrderedIdentityDictionary new
				add: #dropUser -> 'pharounittest';
				yourself).
	root close.