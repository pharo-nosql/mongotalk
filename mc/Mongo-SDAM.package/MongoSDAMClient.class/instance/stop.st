accessing
stop
	mutex critical: [
		mode := #idle.
		monitors do: #stop ]