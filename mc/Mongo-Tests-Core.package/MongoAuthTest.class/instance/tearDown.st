running
tearDown
	root admin
		command:
			(OrderedIdentityDictionary new
				add: #removeUser -> 'pharounittest';
				yourself).
	root close