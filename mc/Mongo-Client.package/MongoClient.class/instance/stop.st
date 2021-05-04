API
stop
	monitors valuesDo: [ :each | 
		[	each isStarted ifTrue: [ each stop ] ] 
			valueWithin: settings monitorStopTimeout
			onTimeout: [ self error: 'Timeout waiting stop of: ', each asString ] ]  