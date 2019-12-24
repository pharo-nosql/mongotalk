accessing
connectTimeout: aDuration
	connectTimeout := aDuration.
	monitors do: [ :each | each pool connectTimeout: aDuration ]