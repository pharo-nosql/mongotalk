private
addMonitorsForAll: newUrlStrings andDo: aBlockClosure
	newUrlStrings do: [ :each |
		| newMonitor |
		topology addServerAt: each.
		newMonitor := MongoSDAMMonitor urlString: each client: self.
		monitors at: each put: newMonitor.
		aBlockClosure cull: newMonitor ]