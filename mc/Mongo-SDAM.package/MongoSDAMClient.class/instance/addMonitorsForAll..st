private
addMonitorsForAll: newUrlStrings

	| newMonitors |
	newUrlStrings do: [ :each | topology addServerAt: each ].
	newMonitors := newUrlStrings collect: [ :each | MongoSDAMMonitor urlString: each client: self ].
	monitors := monitors, newMonitors.
	^ newMonitors