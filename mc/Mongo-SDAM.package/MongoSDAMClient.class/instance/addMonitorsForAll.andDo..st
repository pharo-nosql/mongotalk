private
addMonitorsForAll: newUrlStrings andDo: aBlockClosure
	newUrlStrings do: [ :each | 
		| newMonitor initialServerDescription |
		initialServerDescription := MongoSDAMUnknownServerDescription urlString: each.
		topology basicServerAt: each put: initialServerDescription.
		newMonitor := MongoSDAMMonitor
			urlString: each
			client: self
			initialServerDescription: initialServerDescription.
		monitors at: each put: newMonitor.
		aBlockClosure cull: newMonitor ]