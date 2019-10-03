private
addMonitorsForAll: newUrlStrings andDo: aBlockClosure
	newUrlStrings do: [ :each |
		| newMonitor |
		topology addServerAt: each.
		newMonitor := MongoSDAMMonitor urlString: each client: self.
		newMonitor pool
			connectTimeout: self connectTimeout;
			socketTimeout: self socketTimeout.
		monitors at: each put: newMonitor.
		aBlockClosure cull: newMonitor ]