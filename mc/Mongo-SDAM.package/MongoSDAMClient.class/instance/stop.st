accessing
stop
	mutex critical: [
		monitors valuesDo: #stop ]