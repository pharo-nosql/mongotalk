accessing
stop
	mutex critical: [
		monitors do: #stop ]