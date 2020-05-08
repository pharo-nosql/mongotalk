private
discoverUrlsFrom: urlsAsStrings
	"MongoDB specs state that hosts must not be removed from the list of known hosts: any host may dissapear temporarily only.
	Note 1: This method assumes discovery is performed when monitors are started, then it starts any new monitor.
	Note 2: Caller must ensure in critical region."

	(urlsAsStrings difference: topology serversUrlStrings) ifNotEmpty: [ :newUrlsAsStrings |
		self addMonitorsForAll: newUrlsAsStrings andDo: #start ].
