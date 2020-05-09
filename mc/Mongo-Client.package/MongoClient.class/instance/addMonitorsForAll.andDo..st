private
addMonitorsForAll: newUrlStrings andDo: aBlockClosure
	newUrlStrings do: [ :each | 
		| newMonitor initialServerDescription |
		initialServerDescription := MongoUnknownServerDescription urlString: each.
		topology basicServerAt: each put: initialServerDescription.
		newMonitor := MongoMonitor
			urlString: each
			client: self
			initialServerDescription: initialServerDescription.
		monitors at: each put: newMonitor.
		aBlockClosure cull: newMonitor ]