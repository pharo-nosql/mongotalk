API
stop
	mutex critical: [
		monitors valuesDo: #stop ]