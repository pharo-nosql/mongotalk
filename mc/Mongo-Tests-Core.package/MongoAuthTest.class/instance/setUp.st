running
setUp
	root := Mongo default.
	root open.
	root admin
		command:
			(OrderedIdentityDictionary new
				add: #createUser -> 'pharounittest';
				add: #pwd -> 'test';
				add: #roles -> {};
				yourself)