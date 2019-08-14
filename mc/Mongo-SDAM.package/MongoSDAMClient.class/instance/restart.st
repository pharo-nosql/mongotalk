API
restart
	mutex critical: [
		monitors valuesDo: #stop.
		monitors valuesDo: #start ]
