accessing
socketTimeout: aDuration
	socketTimeout := aDuration.
	monitors do: [ :each | each pool socketTimeout: aDuration ]