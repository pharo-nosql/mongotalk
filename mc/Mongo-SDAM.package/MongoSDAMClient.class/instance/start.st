API
start
	mutex critical: [
		monitors valuesDo: #start ].
